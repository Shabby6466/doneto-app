import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingChangeState.initial()) {
    on<OnboardingIdentityEvent>(onOnboardingIdentityEvent);
    on<UpdatePageEvent>(_updatePage);
    on<NextPageEvent>(_nextPage);
    on<BackPageEvent>(_backPage);
  }

  void onOnboardingIdentityEvent(OnboardingIdentityEvent event, Emitter<OnboardingState> emit) {
    emit(getBlocState(onboardingIdentity: event.onboardingIdentity));
  }

  void _updatePage(UpdatePageEvent event, Emitter<OnboardingState> emit) {
    emit(getBlocState(currentPage: event.page));
  }

  void _nextPage(NextPageEvent event, Emitter<OnboardingState> emit) {
    if (state.currentPage < 2) {
      emit(getBlocState(currentPage: state.currentPage + 1));
    }
  }

  void _backPage(BackPageEvent event, Emitter<OnboardingState> emit) {
    if (state.currentPage > 0) {
      emit(getBlocState(currentPage: state.currentPage - 1));
    }
  }

  /// this method used as state change
  OnboardingState getBlocState({bool? loading, String? errMsg, OnboardingIdentity? onboardingIdentity, int? currentPage}) {
    return OnboardingChangeState(
      errMsg: errMsg ?? state.errMsg,
      loading: loading ?? state.loading,
      onboardingIdentity: onboardingIdentity ?? state.onboardingIdentity,
      currentPage: currentPage ?? state.currentPage,
    );
  }
}

/// bloc states
@immutable
abstract class OnboardingState {
  const OnboardingState({required this.loading, required this.errMsg, required this.onboardingIdentity, required this.currentPage});

  final bool loading;
  final OnboardingIdentity onboardingIdentity;
  final String errMsg;
  final int currentPage;
}

class OnboardingChangeState extends OnboardingState {
  const OnboardingChangeState({required super.loading, required super.errMsg, required super.onboardingIdentity, required super.currentPage});

  factory OnboardingChangeState.initial() =>
      const OnboardingChangeState(loading: false, errMsg: '', onboardingIdentity: OnboardingIdentity.yourself, currentPage: 0);
}

/// bloc events
@immutable
abstract class OnboardingEvent {}

class OnboardingIdentityEvent extends OnboardingEvent {
  final OnboardingIdentity onboardingIdentity;

  OnboardingIdentityEvent({required this.onboardingIdentity});
}

class UpdatePageEvent extends OnboardingEvent {
  final int page;

  UpdatePageEvent({required this.page});
}

class NextPageEvent extends OnboardingEvent {}

class BackPageEvent extends OnboardingEvent {}

enum OnboardingIdentity { yourself, charity, someoneElse }
