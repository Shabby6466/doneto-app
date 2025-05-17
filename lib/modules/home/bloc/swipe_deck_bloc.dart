import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwipeDeckBloc extends Bloc<SwipeDeckEvent, SwipeDeckState> {
  final int itemCount;

  SwipeDeckBloc(this.itemCount) : super(SwipeDeckChangeState.initial()) {
    on<SwipeDeckDragStart>(_onDragStart);
    on<SwipeDeckDragUpdate>(_onDragUpdate);
    on<SwipeDeckDragEnd>(_onDragEnd);
    on<SwipeDeckNextCard>(_onNext);
    on<SwipeDeckPreviousCard>(_onPrev);
  }

  void _onDragStart(SwipeDeckDragStart e, Emitter<SwipeDeckState> emit) {
    emit(getBlocState(dragStartX: e.globalX, isDragging: true));
  }

  void _onDragUpdate(SwipeDeckDragUpdate e, Emitter<SwipeDeckState> emit) {
    final dx = e.globalX - state.dragStartX;
    emit(getBlocState(dragX: dx));
  }

  void _onDragEnd(SwipeDeckDragEnd _, Emitter<SwipeDeckState> emit) {
    var newIndex = state.currentIndex;
    final dx = state.dragX;
    if (dx.abs() > state.dragThreshold) {
      if (dx < 0) {
        newIndex = (state.currentIndex + 1) % itemCount;
      } else {
        newIndex = (state.currentIndex - 1 + itemCount) % itemCount;
      }
    }
    emit(getBlocState(currentIndex: newIndex, dragX: 0, isDragging: false));
  }

  void _onNext(SwipeDeckNextCard _, Emitter<SwipeDeckState> emit) {
    final next = (state.currentIndex + 1) % itemCount;
    emit(getBlocState(currentIndex: next));
  }

  void _onPrev(SwipeDeckPreviousCard _, Emitter<SwipeDeckState> emit) {
    final prev = (state.currentIndex - 1 + itemCount) % itemCount;
    emit(getBlocState(currentIndex: prev));
  }

  SwipeDeckState getBlocState({
    bool? loading,
    String? errMsg,
    int? maxVisible,
    double? tiltAngle,
    double? scaleGap,
    double? offsetGap,
    double? dragThreshold,
    int? currentIndex,
    double? dragStartX,
    double? dragX,
    bool? isDragging,
    //
  }) {
    return SwipeDeckChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      currentIndex: currentIndex ?? state.currentIndex,
      dragStartX: dragStartX ?? state.dragStartX,
      dragX: dragX ?? state.dragX,
      isDragging: isDragging ?? state.isDragging,
      maxVisible: maxVisible ?? state.maxVisible,
      tiltAngle: tiltAngle ?? state.tiltAngle,
      scaleGap: scaleGap ?? state.scaleGap,
      offsetGap: offsetGap ?? state.offsetGap,
      dragThreshold: dragThreshold ?? state.dragThreshold,
    );
  }
}

@immutable
class SwipeDeckState {
  const SwipeDeckState({
    required this.loading,
    required this.errMsg,
    required this.currentIndex,
    required this.dragStartX,
    required this.dragX,
    required this.isDragging,
    required this.maxVisible,
    required this.tiltAngle,
    required this.scaleGap,
    required this.offsetGap,
    required this.dragThreshold,

    //
  });

  final int maxVisible;
  final double tiltAngle;
  final double scaleGap;
  final double offsetGap;
  final double dragThreshold;
  final int currentIndex;
  final double dragStartX;
  final double dragX;
  final bool isDragging;
  final bool loading;
  final String errMsg;
}

class SwipeDeckChangeState extends SwipeDeckState {
  const SwipeDeckChangeState({
    required super.currentIndex,
    required super.dragStartX,
    required super.dragX,
    required super.isDragging,
    required super.maxVisible,
    required super.tiltAngle,
    required super.scaleGap,
    required super.offsetGap,
    required super.dragThreshold,
    required super.loading,
    required super.errMsg,

    //
  });

  factory SwipeDeckChangeState.initial() => const SwipeDeckChangeState(
    loading: false,
    errMsg: '',
    currentIndex: 0,
    dragStartX: 0,
    dragX: 0,
    isDragging: false,
    maxVisible: 3,
    tiltAngle: 6 * pi / 180,
    scaleGap: 0.05,
    offsetGap: 16.0,
    dragThreshold: 60.0,

    //
  );
}

@immutable
abstract class SwipeDeckEvent {}

class SwipeDeckDragStart extends SwipeDeckEvent {
  final double globalX;

  SwipeDeckDragStart(this.globalX);
}

class SwipeDeckDragUpdate extends SwipeDeckEvent {
  final double globalX;

  SwipeDeckDragUpdate(this.globalX);
}

class SwipeDeckDragEnd extends SwipeDeckEvent {}

class SwipeDeckNextCard extends SwipeDeckEvent {}

class SwipeDeckPreviousCard extends SwipeDeckEvent {}
