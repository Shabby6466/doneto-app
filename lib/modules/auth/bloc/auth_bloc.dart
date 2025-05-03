import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/firebase_auth/firebase_auth_service.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/modules/auth/usecase/get_token_usecase.dart';
import 'package:doneto/modules/auth/usecase/save_token_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.saveTokenUseCase, required this.getTokenUseCase}) : super(AuthChangeState.initial()) {
    on<SignInUsingGoogleEvent>(_signInUsingGoogle);
    on<ClearAuthStateEvent>(clearAuthState);
    on<GetTokenEvent>(_getToken);
  }

  final SaveTokenUseCase saveTokenUseCase;
  final GetTokenUseCase getTokenUseCase;

  Future<void> _signInUsingGoogle(SignInUsingGoogleEvent event, Emitter<AuthState> emit) async {
    emit(getBlocState(loading: true));
    try {
      final cred = await sl<FirebaseAuthService>().signInWithGoogle();
      await saveTokenUseCase.call(cred!.user!.uid);
      emit(GoogleLoginSuccessState(userCredential: cred, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(GoogleLoginFailedState(userCredential: state.userCredential, loading: false, errMsg: e.message));
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
  const AuthState({required this.loading, required this.userCredential, required this.errMsg});

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

class TokenFoundState extends AuthState {
  const TokenFoundState({required super.loading, required super.userCredential, required super.errMsg});
}

class TokenNotFoundState extends AuthState {
  const TokenNotFoundState({required super.loading, required super.userCredential, required super.errMsg});
}

/// bloc events
@immutable
class AuthEvent {}

class ClearAuthStateEvent extends AuthEvent {}

class SignInUsingGoogleEvent extends AuthEvent {}

class GetTokenEvent extends AuthEvent {}
