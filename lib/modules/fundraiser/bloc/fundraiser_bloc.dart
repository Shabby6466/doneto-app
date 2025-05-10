import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundraiserBloc extends Bloc<FundraiserEvent, FundraiserState> {
  FundraiserBloc() : super(FundraiserChangeState.initial()) {
    on<FundraiserPageChangeEvent>(_fundraiserPageChangeEvent);
    on<BeneficiaryChangeStateEvent>(_changeBeneficiary);
    on<FundraiserAmountEvent>(_changeFundraiserAmount);
    on<FundraiserCategoryEvent>(_changeFundraiserCategory);
    on<FundraiserTitleEvent>(_changeTitle);
    on<FundraiserDescEvent>(_changeFundraiserDesc);
    on<FundraiserLocationEvent>(_changeBeneficiaryLocation);
  }

  void _fundraiserPageChangeEvent(FundraiserPageChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(currentIndex: event.currentIndex));
  }

  void _changeTitle(FundraiserTitleEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(fundraiserTitle: event.fundraiserTitle));
  }

  void _changeFundraiserDesc(FundraiserDescEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(fundraiserDesc: event.fundraiserDesc));
  }

  void _changeBeneficiary(BeneficiaryChangeStateEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(beneficiaryType: event.beneficiaryName));
  }

  void _changeFundraiserAmount(FundraiserAmountEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(fundraiserAmount: event.fundraiserAmount));
  }

  void _changeFundraiserCategory(FundraiserCategoryEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(fundraiserCategory: event.fundraiserCategory));
  }

  void _changeBeneficiaryLocation(FundraiserLocationEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(location: event.location));
  }

  /// this method used as state change
  FundraiserState getBlocState({
    bool? loading,
    String? errMsg,
    int? currentIndex,
    BeneficiaryType? beneficiaryType,
    String? fundraiserAmount,
    String? fundraiserCategory,
    String? location,
    String? fundraiserDesc,
    String? fundraiserTitle,
    //
  }) {
    return FundraiserChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      currentIndex: currentIndex ?? state.currentIndex,
      beneficiaryType: beneficiaryType ?? state.beneficiaryType,
      fundraiserAmount: fundraiserAmount ?? state.fundraiserAmount,
      fundraiserCategory: fundraiserCategory ?? state.fundraiserCategory,
      location: location ?? state.location,
      fundraiserDesc: fundraiserDesc ?? state.fundraiserDesc,
      fundraiserTitle: fundraiserTitle ?? state.fundraiserTitle,
      //
    );
  }
}

/// bloc states
@immutable
abstract class FundraiserState {
  FundraiserState({
    required this.loading,
    required this.errMsg,
    required this.currentIndex,
    required this.beneficiaryType,
    required this.fundraiserAmount,
    required this.fundraiserCategory,
    required this.location,
    required this.fundraiserTitle,
    required this.fundraiserDesc,
    //
  });

  final bool loading;
  final int currentIndex;
  final String errMsg;
  final BeneficiaryType beneficiaryType;
  final String fundraiserAmount;
  final String location;
  final String fundraiserCategory;
  final String fundraiserTitle;
  final String fundraiserDesc;
}

class FundraiserChangeState extends FundraiserState {
  FundraiserChangeState({
    required super.loading,
    required super.errMsg,
    required super.currentIndex,
    required super.fundraiserAmount,
    required super.location,
    required super.beneficiaryType,
    required super.fundraiserCategory,
    required super.fundraiserTitle,
    required super.fundraiserDesc,
    //
  });

  factory FundraiserChangeState.initial() => FundraiserChangeState(
    loading: false,
    errMsg: '',
    currentIndex: 0,
    beneficiaryType: BeneficiaryType.none,
    fundraiserAmount: '0',
    fundraiserCategory: '',
    location: '',
    fundraiserTitle: '',
    fundraiserDesc: '',
    //
  );
}

enum BeneficiaryType { yourself, charity, someoneElse, none }

/// bloc events
@immutable
abstract class FundraiserEvent {}

class FundraiserPageChangeEvent extends FundraiserEvent {
  final int currentIndex;

  FundraiserPageChangeEvent({required this.currentIndex});
}

class BeneficiaryChangeStateEvent extends FundraiserEvent {
  final BeneficiaryType beneficiaryName;

  BeneficiaryChangeStateEvent({required this.beneficiaryName});
}

class FundraiserAmountEvent extends FundraiserEvent {
  final String fundraiserAmount;

  FundraiserAmountEvent({required this.fundraiserAmount});
}

class FundraiserCategoryEvent extends FundraiserEvent {
  final String fundraiserCategory;

  FundraiserCategoryEvent({required this.fundraiserCategory});
}

class FundraiserLocationEvent extends FundraiserEvent {
  final String location;

  FundraiserLocationEvent({required this.location});
}

class FundraiserTitleEvent extends FundraiserEvent {
  final String fundraiserTitle;

  FundraiserTitleEvent({required this.fundraiserTitle});
}

class FundraiserDescEvent extends FundraiserEvent {
  final String fundraiserDesc;

  FundraiserDescEvent({required this.fundraiserDesc});
}
