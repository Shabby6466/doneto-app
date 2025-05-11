import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/firebase_service/firebase_auth_service.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/modules/auth/usecase/delete_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/get_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/get_user_profile_usecase.dart';
import 'package:doneto/modules/auth/usecase/save_token_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.saveTokenUseCase,
    required this.getTokenUseCase,
    required this.deleteTokenUseCase,
    required this.getUserProfileUseCase,
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
    on<GetUserProfileEvent>(_getUserProfile);
  }

  final SaveTokenUseCase saveTokenUseCase;
  final GetTokenUseCase getTokenUseCase;
  final DeleteTokenUseCase deleteTokenUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;

  Future<void> _getUserProfile(GetUserProfileEvent event, Emitter<AuthState> emit) async {
    try {
      emit(getBlocState(loading: true));
      final res = await getUserProfileUseCase.call(NoParams());
      emit(
        getBlocState(
          loading: false,
          errMsg: '',
          email: res.email,
          phoneNumber: res.phoneNumber,
          instagramHandle: res.instagramHandle,
          imageUrl: res.imageUrl,
          fullName: res.fullName,
        ),
      );
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  void _clearState(ClearState event, Emitter<AuthState> emit) {
    emit(AuthChangeState.initial());
  }

  void _loginBeforeFundraiser(LoginBeforeFundraiserEvent event, Emitter<AuthState> emit) {
    emit(
      LoginBeforeFundraiserState(
        loading: state.loading,
        userCredential: state.userCredential,
        errMsg: state.errMsg,
        email: state.email,
        phoneNumber: state.phoneNumber,
        instagramHandle: state.instagramHandle,
        imageUrl: state.imageUrl,
        fullName: state.fullName,
      ),
    );
  }

  Future<void> _signInUsingGoogle(SignInUsingGoogleEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      final cred = await sl<FirebaseService>().signInWithGoogle();
      await saveTokenUseCase.call(cred!.user!.uid);
      emit(
        GoogleLoginSuccessState(
          userCredential: cred,
          loading: false,
          errMsg: '',
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    } on DefaultFailure catch (e) {
      emit(
        GoogleLoginFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: e.message,
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      await sl<FirebaseService>().signOut();
      deleteTokenUseCase.call(NoParams());
      emit(
        LogoutSuccessState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: '',
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    } on DefaultFailure catch (e) {
      emit(
        LogoutFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: e.message,
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    }
  }

  Future<void> _getToken(GetTokenEvent event, Emitter<AuthState> emit) async {
    try {
      await getTokenUseCase.call(NoParams());
      emit(
        TokenFoundState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: '',
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    } on DefaultFailure catch (e) {
      emit(
        TokenNotFoundState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: e.message,
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
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
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
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
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
          //
        ),
      );
    } on DefaultFailure catch (e) {
      emit(
        SignUpWithEmailFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: e.message,
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
          //
        ),
      );
    }
  }

  Future<void> checkEmailVerified(CheckEmailVerifiedEvent event, Emitter<AuthState> emit) async {
    emit(
      EmailVerificationLoadingState(
        userCredential: null,
        loading: true,
        errMsg: 'Checking…',
        email: state.email,
        phoneNumber: state.phoneNumber,
        instagramHandle: state.instagramHandle,
        imageUrl: state.imageUrl,
        fullName: state.fullName,
      ),
    );
    try {
      final user = sl<FirebaseAuth>().currentUser;
      await user?.reload();

      if (user?.emailVerified ?? false) {
        emit(
          EmailVerifiedState(
            userCredential: state.userCredential,
            loading: false,
            errMsg: '',
            email: state.email,
            phoneNumber: state.phoneNumber,
            instagramHandle: state.instagramHandle,
            imageUrl: state.imageUrl,
            fullName: state.fullName,
          ),
        );
      } else {
        emit(
          EmailVerificationFailedState(
            userCredential: state.userCredential,
            loading: false,
            errMsg: 'Your e-mail is still not verified. Please check your inbox.',
            email: state.email,
            phoneNumber: state.phoneNumber,
            instagramHandle: state.instagramHandle,
            imageUrl: state.imageUrl,
            fullName: state.fullName,
          ),
        );
      }
    } catch (e) {
      emit(
        EmailVerificationFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: 'Could not check verification. Try again.',
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    }
  }

  Future<void> _signInWithEmail(SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      final cred = await sl<FirebaseService>().signInWithEmail(event.email, event.password);
      await saveTokenUseCase.call(cred!.user!.uid);
      emit(
        TokenFoundState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: '',
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
      emit(
        SignInWithEmailSuccessState(
          userCredential: cred,
          loading: false,
          errMsg: '',
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    } on DefaultFailure catch (e) {
      emit(
        SignInWitheEmailFailedState(
          userCredential: state.userCredential,
          loading: false,
          errMsg: e.message,
          email: state.email,
          phoneNumber: state.phoneNumber,
          instagramHandle: state.instagramHandle,
          imageUrl: state.imageUrl,
          fullName: state.fullName,
        ),
      );
    }
  }

  void clearAuthState(ClearAuthStateEvent event, Emitter<AuthState> emit) {
    emit(AuthChangeState.initial());
  }

  /// this method used as state change
  AuthState getBlocState({
    bool? loading,
    String? errMsg,
    int? index,
    UserCredential? userCredential,
    String? fullName,
    String? phoneNumber,
    String? imageUrl,
    String? email,
    String? instagramHandle,
    //
  }) {
    return AuthChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      userCredential: userCredential ?? state.userCredential,
      email: email ?? state.email,
      fullName: fullName ?? state.fullName,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      imageUrl: imageUrl ?? state.imageUrl,
      instagramHandle: instagramHandle ?? state.instagramHandle,
    );
  }
}

/// bloc states
@immutable
class AuthState {
  const AuthState({
    required this.loading,
    required this.userCredential,
    required this.errMsg,
    required this.fullName,
    required this.phoneNumber,
    required this.imageUrl,
    required this.email,
    required this.instagramHandle,
    //
  });

  final bool loading;
  final String errMsg;
  final UserCredential? userCredential;
  final String? fullName;
  final String? phoneNumber;
  final String? imageUrl;
  final String? email;
  final String? instagramHandle;
}

class AuthChangeState extends AuthState {
  const AuthChangeState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
    //
  });

  factory AuthChangeState.initial() => const AuthChangeState(
    loading: false,
    errMsg: '',
    userCredential: null,
    email: '',
    fullName: '',
    imageUrl: '',
    instagramHandle: '',
    phoneNumber: '',
    //
  );
}

class GoogleLoginSuccessState extends AuthState {
  const GoogleLoginSuccessState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class GoogleLoginFailedState extends AuthState {
  const GoogleLoginFailedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class LogoutSuccessState extends AuthState {
  const LogoutSuccessState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class LogoutFailedState extends AuthState {
  const LogoutFailedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class TokenFoundState extends AuthState {
  const TokenFoundState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class TokenNotFoundState extends AuthState {
  const TokenNotFoundState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class EmailVerificationFailedState extends AuthState {
  const EmailVerificationFailedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class SignInWithEmailSuccessState extends AuthState {
  const SignInWithEmailSuccessState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class SignInWitheEmailFailedState extends AuthState {
  const SignInWitheEmailFailedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class SignUpWithEmailFailedState extends AuthState {
  const SignUpWithEmailFailedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class SignUpWithEmailSuccessState extends AuthState {
  const SignUpWithEmailSuccessState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class LoginBeforeFundraiserState extends AuthState {
  const LoginBeforeFundraiserState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
  });
}

class EmailVerificationRequiredState extends AuthState {
  const EmailVerificationRequiredState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
    //
  });
}

class EmailVerifiedState extends AuthState {
  const EmailVerifiedState({
    required super.loading,
    required super.userCredential,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
    //
  });
}

class EmailVerificationLoadingState extends AuthState {
  const EmailVerificationLoadingState({
    required super.userCredential,
    required super.loading,
    required super.errMsg,
    required super.email,
    required super.fullName,
    required super.imageUrl,
    required super.instagramHandle,
    required super.phoneNumber,
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

class GetUserProfileEvent extends AuthEvent {}
