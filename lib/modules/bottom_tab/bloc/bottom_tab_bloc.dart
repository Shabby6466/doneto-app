import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTabBloc extends Bloc<BottomTabEvent, BottomTabState> {
  BottomTabBloc() : super(BottomTabChangeState.initial()) {
    on<ChangeBottomTabIndexEvent>(_changeBottomTabIndexEvent);
    on<ClearBottomTabStateEvent>(clearBottomTabState);
  }

  void _changeBottomTabIndexEvent(ChangeBottomTabIndexEvent event, Emitter<BottomTabState> emit) {
    emit(getBlocState(index: event.index));
  }

  void clearBottomTabState(ClearBottomTabStateEvent event, Emitter<BottomTabState> emit) {
    emit(BottomTabChangeState.initial());
  }

  /// this method used as state change
  BottomTabState getBlocState({
    bool? loading,
    String? errMsg,
    int? index,
  }) {
    return BottomTabChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      index: index ?? state.index,
    );
  }
}

/// bloc states
@immutable
class BottomTabState {
  const BottomTabState({
    required this.loading,
    required this.errMsg,
    required this.index,
  });

  final bool loading;
  final String errMsg;
  final int index;
}

class BottomTabChangeState extends BottomTabState {
  const BottomTabChangeState({
    required super.loading,
    required super.errMsg,
    required super.index,
  });

  factory BottomTabChangeState.initial() => const BottomTabChangeState(
    loading: false,
    errMsg: '',
    index: 0,
  );
}

/// bloc events
@immutable
class BottomTabEvent {}

class ChangeBottomTabIndexEvent extends BottomTabEvent {
  final int index;

  ChangeBottomTabIndexEvent({required this.index});
}

class ClearBottomTabStateEvent extends BottomTabEvent {}
