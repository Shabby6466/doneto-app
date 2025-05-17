import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/fundraiser/usecases/watch_all_fundraisers.dart';
import 'package:doneto/modules/home/usecases/get_user_by_id_usecase.dart';
import 'package:doneto/modules/home/usecases/watch_fundraisers_by_city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getUserByIdUseCase,
    required this.watchAllFundraisers,
    required this.watchFundraisersByCityUseCase,
    //
  }) : super(HomeChangeState.initial()) {
    on<SearchingEvent>(_searching);
    on<StopSearchingEvent>(_stopSearching);
    on<GetUserProfileByIdEvent>(_getUserById);
    on<LoadFundraisersEvent>(_onLoadFundraisers);
    on<SearchFundraisersEvent>(_onSearchFundraisers);
    on<ClearSearchEvent>(_onClearSearch);
    on<FeaturedFundraisersEvent>(_featuredFundraisers);
    on<DonetoVerifiedFundraisersEvent>(_donetoVerifiedFundraisers);
    on<DonetoVerifiedSearchEvent>(_onDonetoVerifiedSearch);
    on<TotalFundraisersEvent>(_totalFundraisers);
    on<SelectCityEvent>(_selectCity);
    //
  }

  final WatchAllFundraisersUseCase watchAllFundraisers;
  final WatchFundraisersByCityUseCase watchFundraisersByCityUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  void _selectCity(SelectCityEvent event, Emitter<HomeState> emit) async {
    emit(getBlocState(city: event.city, province: event.province, loading: true, errMsg: ''));

    try {
      final provCity = '${state.province}, ${state.city}';
      final res = watchFundraisersByCityUseCase.calling(provCity);
      emit(getBlocState(loading: false, cityFundraisers: res));
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  void _totalFundraisers(TotalFundraisersEvent event, Emitter<HomeState> emit) {
    emit(getBlocState(totalFundraisers: event.total));
  }

  // inside HomeBloc…

  Future<void> _donetoVerifiedFundraisers(
      DonetoVerifiedFundraisersEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(getBlocState(loading: true, errMsg: ''));

    final filteredStream = watchAllFundraisers
        .calling(NoParams())
        .map((allList) =>
        allList.where((f) => f.donetoVerified).toList())
        .asBroadcastStream();

    emit(getBlocState(
      loading: false,
      donetoVerifiedFundraisers: filteredStream,
    ));
  }


  void _featuredFundraisers(FeaturedFundraisersEvent event, Emitter<HomeState> emit) async {
    try {
      emit(getBlocState(loading: true, errMsg: ''));
      final Stream<List<Fundraiser>> stream = watchAllFundraisers.calling(NoParams());
      sl<Logger>().f('Featured Stream | $stream');
      await for (final allList in stream) {
        final featuredList = allList.where((f) => f.featured == true).toList();

        emit(getBlocState(loading: false, featuredFundraisers: featuredList));
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

  void _onDonetoVerifiedSearch(DonetoVerifiedSearchEvent event, Emitter<HomeState> emit) {
    final filtered = _applyFilter(state.verifiedFundraisers, event.query);
    emit(getBlocState(query: event.query, filteredFundraisers: filtered));
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
        city: state.city,
        province: state.province,
        cityFundraisers: state.cityFundraisers,
        allFundraisers: state.allFundraisers,
        featuredFundraisers: state.featuredFundraisers,
        totalFundraisers: state.totalFundraisers,
        filteredFundraisers: state.filteredFundraisers,
        donetoVerifiedFundraisers: state.donetoVerifiedFundraisers,
        verifiedFundraisers: state.verifiedFundraisers,
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
    int? totalFundraisers,
    String? query,
    String? city,
    String? province,
    UserProfile? userProfile,
    List<Fundraiser>? allFundraisers,
    List<Fundraiser>? filteredFundraisers,
    Stream<List<Fundraiser>>? donetoVerifiedFundraisers,
    List<Fundraiser>? verifiedFundraisers,
    List<Fundraiser>? featuredFundraisers,
    Stream<List<Fundraiser>>? cityFundraisers,
    //
  }) {
    return HomeChangeState(
      loading: loading ?? state.loading,
      query: query ?? state.query,
      city: city ?? state.city,
      province: province ?? state.province,
      totalFundraisers: totalFundraisers ?? state.totalFundraisers,
      donetoVerifiedFundraisers: donetoVerifiedFundraisers ?? state.donetoVerifiedFundraisers,
      verifiedFundraisers: verifiedFundraisers ?? state.verifiedFundraisers,
      errMsg: errMsg ?? state.errMsg,
      allFundraisers: allFundraisers ?? state.allFundraisers,
      filteredFundraisers: filteredFundraisers ?? state.filteredFundraisers,
      featuredFundraisers: featuredFundraisers ?? state.featuredFundraisers,
      cityFundraisers: cityFundraisers ?? state.cityFundraisers,
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
    required this.cityFundraisers,
    required this.city,
    required this.province,
    required this.featuredFundraisers,
    required this.donetoVerifiedFundraisers,
    required this.verifiedFundraisers,
    required this.query,
    required this.filteredFundraisers,
    required this.errMsg,
    required this.totalFundraisers,
    required this.index,
    //
  });

  final bool loading;
  final String errMsg;
  final String query;
  final String city;
  final String province;
  final int totalFundraisers;
  final List<Fundraiser> allFundraisers;
  final Stream<List<Fundraiser>> cityFundraisers;
  final List<Fundraiser> featuredFundraisers;
  final Stream<List<Fundraiser>>? donetoVerifiedFundraisers;
  final List<Fundraiser> verifiedFundraisers;
  final List<Fundraiser> filteredFundraisers;
  final UserProfile? userProfile;
  final int index;
}

class HomeChangeState extends HomeState {
  const HomeChangeState({
    required super.loading,
    required super.query,
    required super.cityFundraisers,
    required super.donetoVerifiedFundraisers,
    required super.verifiedFundraisers,
    required super.city,
    required super.province,
    required super.allFundraisers,
    required super.totalFundraisers,
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
    city: 'Rawalpindi',
    province: 'Punjab',
    totalFundraisers: 0,
    userProfile: UserProfile.initial(),
    query: '',
    allFundraisers: [],
    cityFundraisers: const Stream.empty(),
    featuredFundraisers: [],
    donetoVerifiedFundraisers: const Stream.empty(),
    verifiedFundraisers: [],
    filteredFundraisers: [],
    index: 0,
    //
  );
}

class SearchingState extends HomeState {
  const SearchingState({
    required super.loading,
    required super.cityFundraisers,
    required super.errMsg,
    required super.city,
    required super.province,
    required super.query,
    required super.index,
    required super.allFundraisers,
    required super.donetoVerifiedFundraisers,
    required super.verifiedFundraisers,
    required super.filteredFundraisers,
    required super.totalFundraisers,
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

class DonetoVerifiedFundraisersEvent extends HomeEvent {}

class DonetoVerifiedSearchEvent extends HomeEvent {
  final String query;

  DonetoVerifiedSearchEvent({required this.query});
}

class TotalFundraisersEvent extends HomeEvent {
  final int total;

  TotalFundraisersEvent({required this.total});
}

class SelectCityEvent extends HomeEvent {
  final String city;
  final String province;

  SelectCityEvent({required this.city, required this.province});
}
