import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/home/usecases/get_user_by_id_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getUserByIdUseCase,
    //
  }) : super(HomeChangeState.initial()) {
    on<SearchingEvent>(_searching);
    on<StopSearchingEvent>(_stopSearching);
    on<GetUserProfileByIdEvent>(_getUserById);
    //
  }

  final GetUserByIdUseCase getUserByIdUseCase;

  void _getUserById(GetUserProfileByIdEvent event, Emitter<HomeState> emit) async {
    try {
      emit(getBlocState(loading: true, errMsg: ''));
      final res = await getUserByIdUseCase.call(event.userId);
      emit(getBlocState(userProfile: res, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  void _searching(SearchingEvent event, Emitter<HomeState> emit) {
    emit(
      SearchingState(
        loading: state.loading,
        userProfile: state.userProfile,
        errMsg: state.errMsg,
        index: state.index,
        //
      ),
    );
  }

  void _stopSearching(StopSearchingEvent event, Emitter<HomeState> emit) {
    emit(HomeChangeState.initial());
  }

  /// this method used as state change
  HomeState getBlocState({
    bool? loading,
    String? errMsg,
    int? index,
    UserProfile? userProfile,
    //
  }) {
    return HomeChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      userProfile: userProfile ?? state.userProfile,
      index: index ?? state.index,
      //
    );
  }
}

/// bloc states
@immutable
class HomeState {
  const HomeState({
    required this.loading,
    required this.userProfile,
    required this.errMsg,
    required this.index,
    //
  });

  final bool loading;
  final String errMsg;
  final UserProfile? userProfile;
  final int index;
}

class HomeChangeState extends HomeState {
  const HomeChangeState({
    required super.loading,
    required super.userProfile,
    required super.errMsg,
    required super.index,
    //
  });

  factory HomeChangeState.initial() => HomeChangeState(
    loading: false,
    errMsg: '',
    userProfile: UserProfile.initial(),
    index: 0,
    //
  );
}

class SearchingState extends HomeState {
  const SearchingState({
    required super.loading,
    required super.errMsg,
    required super.index,
    required super.userProfile,
    //
  });
}

/// bloc events
@immutable
class HomeEvent {}

class SearchingEvent extends HomeEvent {}

class StopSearchingEvent extends HomeEvent {}

class GetUserProfileByIdEvent extends HomeEvent {
  final String userId;

  GetUserProfileByIdEvent({required this.userId});
}
