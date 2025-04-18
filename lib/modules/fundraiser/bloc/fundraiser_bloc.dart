import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundraiserBloc extends Bloc<FundraiserEvent, FundraiserState> {
  FundraiserBloc() : super(FundraiserChangeState.initial()) {}

  /// this method used as state change
  FundraiserState getBlocState({bool? loading, String? errMsg, int? currentIndex}) {
    return FundraiserChangeState(loading: loading ?? state.loading, errMsg: errMsg ?? state.errMsg, currentIndex: currentIndex ?? state.currentIndex);
  }
}

/// bloc states
@immutable
abstract class FundraiserState {
  const FundraiserState({required this.loading, required this.errMsg, required this.currentIndex});

  final bool loading;
  final int currentIndex;
  final String errMsg;
}

class FundraiserChangeState extends FundraiserState {
  const FundraiserChangeState({required super.loading, required super.errMsg, required super.currentIndex});

  factory FundraiserChangeState.initial() => const FundraiserChangeState(loading: false, errMsg: '', currentIndex: 0);
}

/// bloc events
@immutable
abstract class FundraiserEvent {}
