import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeChangeState.initial()) {
    on<SearchingEvent>(_searching);
    on<StopSearchingEvent>(_stopSearching);
    //
  }

  void _searching(SearchingEvent event, Emitter<HomeState> emit) {
    emit(SearchingState(loading: state.loading, errMsg: state.errMsg, index: state.index));
  }

  void _stopSearching(StopSearchingEvent event, Emitter<HomeState> emit) {
    emit(HomeChangeState.initial());
  }

  /// this method used as state change
  HomeState getBlocState({
    bool? loading,
    String? errMsg,
    int? index,
    //
  }) {
    return HomeChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      index: index ?? state.index,
      //
    );
  }
}

/// bloc states
@immutable
class HomeState {
  const HomeState({required this.loading, required this.errMsg, required this.index});

  final bool loading;
  final String errMsg;
  final int index;
}

class HomeChangeState extends HomeState {
  const HomeChangeState({
    required super.loading,
    required super.errMsg,
    required super.index,
    //
  });

  factory HomeChangeState.initial() => const HomeChangeState(
    loading: false,
    errMsg: '',
    index: 0,
    //
  );
}

class SearchingState extends HomeState {
  const SearchingState({
    required super.loading,
    required super.errMsg,
    required super.index,
    //
  });
}

/// bloc events
@immutable
class HomeEvent {}

class SearchingEvent extends HomeEvent {}

class StopSearchingEvent extends HomeEvent {}
