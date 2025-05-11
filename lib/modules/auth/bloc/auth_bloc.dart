import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/firebase_service/firebase_auth_service.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/modules/auth/usecase/delete_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/get_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/save_token_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.saveTokenUseCase,
    required this.getTokenUseCase,
    required this.deleteTokenUseCase,
    //
  }) : super(AuthChangeState.initial()) {
    on<SignInUsingGoogleEvent>(_signInUsingGoogle);
    on<ClearAuthStateEvent>(clearAuthState);
    on<GetTokenEvent>(_getToken);
    on<LogoutEvent>(_logout);
    on<SignInWithEmailEvent>(_signInWithEmail);
    on<CheckEmailVerifiedEvent>(checkEmailVerified);
    on<SignUpWithEmailEvent>(_signUpWithEmail);
    on<ClearState>(_clearState);
    on<LoginBeforeFundraiserEvent>(_loginBeforeFundraiser);
  }

  final SaveTokenUseCase saveTokenUseCase;
  final GetTokenUseCase getTokenUseCase;
  final DeleteTokenUseCase deleteTokenUseCase;

  void _clearState(ClearState event, Emitter<AuthState> emit) {
    emit(AuthChangeState.initial());
  }

  void _loginBeforeFundraiser(LoginBeforeFundraiserEvent event, Emitter<AuthState> emit) {
    emit(LoginBeforeFundraiserState(loading: state.loading, userCredential: state.userCredential, errMsg: state.errMsg));
  }

  Future<void> _signInUsingGoogle(SignInUsingGoogleEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      final cred = await sl<FirebaseService>().signInWithGoogle();
      await saveTokenUseCase.call(cred!.user!.uid);
      emit(GoogleLoginSuccessState(userCredential: cred, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(GoogleLoginFailedState(userCredential: state.userCredential, loading: false, errMsg: e.message));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      await sl<FirebaseService>().signOut();
      deleteTokenUseCase.call(NoParams());
      emit(LogoutSuccessState(userCredential: state.userCredential, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(LogoutFailedState(userCredential: state.userCredential, loading: false, errMsg: e.message));
    }
  }

  Future<void> _getToken(GetTokenEvent event, Emitter<AuthState> emit) async {
    try {
      await getTokenUseCase.call(NoParams());
      emit(TokenFoundState(userCredential: state.userCredential, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(TokenNotFoundState(userCredential: state.userCredential, loading: false, errMsg: e.message));
    }
  }

  Future<void> _signUpWithEmail(SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    if (event.password != event.confirmPassword) {
      emit(
        SignUpWithEmailFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: 'Passwords don’t match',
          //
        ),
      );
      return;
    }
    try {
      final cred = await sl<FirebaseService>().signUpWithEmail(event.email, event.password);
      emit(
        EmailVerificationRequiredState(
          userCredential: cred,
          loading: false,
          errMsg: 'A verification e-mail has been sent. Please check your inbox.',
          //
        ),
      );
    } on DefaultFailure catch (e) {
      emit(
        SignUpWithEmailFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: e.message,
          //
        ),
      );
    }
  }

  Future<void> checkEmailVerified(CheckEmailVerifiedEvent event, Emitter<AuthState> emit) async {
    emit(const EmailVerificationLoadingState(userCredential: null, loading: true, errMsg: 'Checking…'));
    try {
      final user = sl<FirebaseAuth>().currentUser;
      await user?.reload();

      if (user?.emailVerified ?? false) {
        await saveTokenUseCase.call(user!.uid);
        emit(EmailVerifiedState(userCredential: state.userCredential, loading: false, errMsg: ''));
      } else {
        emit(
          EmailVerificationFailedState(
            userCredential: state.userCredential,
            loading: false,
            errMsg: 'Your e-mail is still not verified. Please check your inbox.',
          ),
        );
      }
    } catch (e) {
      emit(EmailVerificationFailedState(userCredential: state.userCredential, loading: false, errMsg: 'Could not check verification. Try again.'));
    }
  }

  Future<void> _signInWithEmail(SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      final cred = await sl<FirebaseService>().signInWithEmail(event.email, event.password);
      await saveTokenUseCase.call(cred!.user!.uid);
      emit(TokenFoundState(userCredential: state.userCredential, loading: false, errMsg: ''));
      emit(SignInWithEmailSuccessState(userCredential: cred, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(SignInWitheEmailFailedState(userCredential: state.userCredential, loading: false, errMsg: e.message));
    }
  }

  void clearAuthState(ClearAuthStateEvent event, Emitter<AuthState> emit) {
    emit(AuthChangeState.initial());
  }

  /// this method used as state change
  AuthState getBlocState({bool? loading, String? errMsg, int? index, UserCredential? userCredential}) {
    return AuthChangeState(loading: loading ?? state.loading, errMsg: errMsg ?? state.errMsg, userCredential: userCredential ?? state.userCredential);
  }
}

/// bloc states
@immutable
class AuthState {
  const AuthState({
    required this.loading,
    required this.userCredential,
    required this.errMsg,
    //
  });

  final bool loading;
  final String errMsg;
  final UserCredential? userCredential;
}

class AuthChangeState extends AuthState {
  const AuthChangeState({required super.loading, required super.userCredential, required super.errMsg});

  factory AuthChangeState.initial() => const AuthChangeState(loading: false, errMsg: '', userCredential: null);
}

class GoogleLoginSuccessState extends AuthState {
  const GoogleLoginSuccessState({required super.loading, required super.userCredential, required super.errMsg});
}

class GoogleLoginFailedState extends AuthState {
  const GoogleLoginFailedState({required super.loading, required super.userCredential, required super.errMsg});
}

class LogoutSuccessState extends AuthState {
  const LogoutSuccessState({required super.loading, required super.userCredential, required super.errMsg});
}

class LogoutFailedState extends AuthState {
  const LogoutFailedState({required super.loading, required super.userCredential, required super.errMsg});
}

class TokenFoundState extends AuthState {
  const TokenFoundState({required super.loading, required super.userCredential, required super.errMsg});
}

class TokenNotFoundState extends AuthState {
  const TokenNotFoundState({required super.loading, required super.userCredential, required super.errMsg});
}

class EmailVerificationFailedState extends AuthState {
  const EmailVerificationFailedState({required super.loading, required super.userCredential, required super.errMsg});
}

class SignInWithEmailSuccessState extends AuthState {
  const SignInWithEmailSuccessState({required super.loading, required super.userCredential, required super.errMsg});
}

class SignInWitheEmailFailedState extends AuthState {
  const SignInWitheEmailFailedState({required super.loading, required super.userCredential, required super.errMsg});
}

class SignUpWithEmailFailedState extends AuthState {
  const SignUpWithEmailFailedState({required super.loading, required super.userCredential, required super.errMsg});
}

class SignUpWithEmailSuccessState extends AuthState {
  const SignUpWithEmailSuccessState({required super.loading, required super.userCredential, required super.errMsg});
}

class LoginBeforeFundraiserState extends AuthState {
  const LoginBeforeFundraiserState({required super.loading, required super.userCredential, required super.errMsg});
}

class EmailVerificationRequiredState extends AuthState {
  const EmailVerificationRequiredState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    //
  });
}

class EmailVerifiedState extends AuthState {
  const EmailVerifiedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    //
  });
}

/// bloc events
@immutable
class AuthEvent {}

class ClearAuthStateEvent extends AuthEvent {}

class SignInUsingGoogleEvent extends AuthEvent {}

class GetTokenEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailEvent({required this.email, required this.password});
}

class ClearState extends AuthEvent {}

class EmailVerificationSentEvent extends AuthEvent {}

class CheckEmailVerifiedEvent extends AuthEvent {}

class EmailVerificationLoadingState extends AuthState {
  const EmailVerificationLoadingState({
    required super.userCredential,
    required super.loading,
    required super.errMsg,
    //
  });
}

class LoginBeforeFundraiserEvent extends AuthEvent {}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpWithEmailEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    //
  });
}
