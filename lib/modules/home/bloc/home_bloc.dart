import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/fundraiser/usecases/watch_all_fundraisers.dart';
import 'package:doneto/modules/home/usecases/get_user_by_id_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getUserByIdUseCase,
    required this.watchAllFundraisers,
    //
  }) : super(HomeChangeState.initial()) {
    on<SearchingEvent>(_searching);
    on<StopSearchingEvent>(_stopSearching);
    on<GetUserProfileByIdEvent>(_getUserById);
    on<LoadFundraisersEvent>(_onLoadFundraisers);
    on<SearchFundraisersEvent>(_onSearchFundraisers);
    on<ClearSearchEvent>(_onClearSearch);
    on<FeaturedFundraisersEvent>(_featuredFundraisers);
    //
  }

  final WatchAllFundraisersUseCase watchAllFundraisers;
  final GetUserByIdUseCase getUserByIdUseCase;

  void _featuredFundraisers(FeaturedFundraisersEvent event, Emitter<HomeState> emit) async {
    try {
      emit(getBlocState(loading: true, errMsg: ''));
      final res = watchAllFundraisers.calling(NoParams());
      await for (final list in res) {
        final featured = _applyFilter(list, state.query);
        emit(getBlocState(loading: false, featuredFundraisers: featured));
      }
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  void _getUserById(GetUserProfileByIdEvent event, Emitter<HomeState> emit) async {
    try {
      emit(getBlocState(loading: true, errMsg: ''));
      final res = await getUserByIdUseCase.call(event.userId);
      emit(getBlocState(userProfile: res, loading: false, errMsg: ''));
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  Future<void> _onLoadFundraisers(LoadFundraisersEvent event, Emitter<HomeState> emit) async {
    emit(getBlocState(loading: true, errMsg: ''));

    final Stream<List<Fundraiser>> fundraiserStream = watchAllFundraisers.calling(NoParams());

    await for (final list in fundraiserStream) {
      final filtered = _applyFilter(list, state.query);
      emit(getBlocState(loading: false, allFundraisers: list, filteredFundraisers: filtered));
    }
  }

  void _onSearchFundraisers(SearchFundraisersEvent event, Emitter<HomeState> emit) {
    final filtered = _applyFilter(state.allFundraisers, event.query);
    emit(getBlocState(query: event.query, filteredFundraisers: filtered));
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<HomeState> emit) {
    emit(getBlocState(query: '', filteredFundraisers: state.filteredFundraisers));
  }

  List<Fundraiser> _applyFilter(List<Fundraiser> list, String query) {
    if (query.isEmpty) return list;
    final q = query.toLowerCase();
    final matches =
        list.where((f) {
          final t = f.title.toLowerCase();
          final d = (f.description).toLowerCase();
          return t.contains(q) || d.contains(q);
        }).toList();
    matches.sort((a, b) {
      return a.title.toLowerCase().indexOf(q).compareTo(b.title.toLowerCase().indexOf(q));
    });
    return matches;
  }

  void _searching(SearchingEvent event, Emitter<HomeState> emit) {
    emit(
      SearchingState(
        loading: state.loading,
        allFundraisers: state.allFundraisers,
        featuredFundraisers: state.featuredFundraisers,
        filteredFundraisers: state.filteredFundraisers,
        query: state.query,
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
    String? query,
    UserProfile? userProfile,
    List<Fundraiser>? allFundraisers,
    List<Fundraiser>? filteredFundraisers,
    List<Fundraiser>? featuredFundraisers,
    //
  }) {
    return HomeChangeState(
      loading: loading ?? state.loading,
      query: query ?? state.query,
      errMsg: errMsg ?? state.errMsg,
      allFundraisers: allFundraisers ?? state.allFundraisers,
      filteredFundraisers: filteredFundraisers ?? state.filteredFundraisers,
      featuredFundraisers: featuredFundraisers ?? state.featuredFundraisers,
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
    required this.allFundraisers,
    required this.featuredFundraisers,
    required this.query,
    required this.filteredFundraisers,
    required this.errMsg,
    required this.index,
    //
  });

  final bool loading;
  final String errMsg;
  final String query;
  final List<Fundraiser> allFundraisers;
  final List<Fundraiser> featuredFundraisers;
  final List<Fundraiser> filteredFundraisers;
  final UserProfile? userProfile;
  final int index;
}

class HomeChangeState extends HomeState {
  const HomeChangeState({
    required super.loading,
    required super.query,
    required super.allFundraisers,
    required super.filteredFundraisers,
    required super.featuredFundraisers,
    required super.userProfile,
    required super.errMsg,
    required super.index,
    //
  });

  factory HomeChangeState.initial() => HomeChangeState(
    loading: false,
    errMsg: '',
    userProfile: UserProfile.initial(),
    query: '',
    allFundraisers: [],
    featuredFundraisers: [],
    filteredFundraisers: [],
    index: 0,
    //
  );
}

class SearchingState extends HomeState {
  const SearchingState({
    required super.loading,
    required super.errMsg,
    required super.query,
    required super.index,
    required super.allFundraisers,
    required super.filteredFundraisers,
    required super.featuredFundraisers,
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

class ClearSearchEvent extends HomeEvent {}

class SearchFundraisersEvent extends HomeEvent {
  final String query;

  SearchFundraisersEvent({required this.query});
}

class LoadFundraisersEvent extends HomeEvent {}

class FeaturedFundraisersEvent extends HomeEvent {}
