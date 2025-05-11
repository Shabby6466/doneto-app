import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/firebase_service/firebase_auth_service.dart';
import 'package:doneto/core/widgets/funraiser_model.dart';
import 'package:doneto/modules/fundraiser/usecases/create_fundraiser_draft_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class FundraiserBloc extends Bloc<FundraiserEvent, FundraiserState> {
  FundraiserBloc({
    required this.createFundraiserDraftUseCase,
    //
  }) : super(FundraiserChangeState.initial()) {
    on<FundraiserPageChangeEvent>(_fundraiserPageChangeEvent);
    on<FundraiserAmountChangeEvent>(_amountChangeEvent);
    on<FundraiserCountryChangeEvent>(_countryChangeEvent);
    on<FundraiserCategoryChangeEvent>(_categoryChangeEvent);
    on<FundraiserDescriptionChangeEvent>(_descriptionChangeEvent);
    on<FundraiserTitleChangeEvent>(_titleChangeEvent);
    on<CreateFundraiserDraftEvent>(_createFundraiserDraft);
  }

  final CreateFundraiserDraftUseCase createFundraiserDraftUseCase;

  Future<void> _createFundraiserDraft(CreateFundraiserDraftEvent event, Emitter<FundraiserState> emit) async {
    try {
      emit(getBlocState(loading: true));
      final service = sl<FirebaseService>();
      final user = await service.getCurrentUser();
      sl<Logger>().f('USER FIREBASE | $user');
      await createFundraiserDraftUseCase.call(
        Fundraiser(
          id: '',
          ownerId: user!.uid,
          type: FundraiserType.charity,
          targetAmount: 12000,
          category: state.category,
          title: state.fundraiserTitle,
          description: state.fundraiserDescription,
          createdAt: Timestamp.now(),
          //
        ),
      );
      emit(
        FundraiserDraftSuccessState(
          loading: false,
          errMsg: '',
          currentIndex: state.currentIndex,
          amount: state.amount,
          category: state.category,
          country: state.country,
          fundraiserDescription: state.fundraiserDescription,
          fundraiserTitle: state.fundraiserTitle,
          //
        ),
      );
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  void _amountChangeEvent(FundraiserAmountChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(amount: event.amount));
  }

  void _categoryChangeEvent(FundraiserCategoryChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(category: event.category));
  }

  void _countryChangeEvent(FundraiserCountryChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(country: event.country));
  }

  void _titleChangeEvent(FundraiserTitleChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(fundraiserTitle: event.title));
  }

  void _descriptionChangeEvent(FundraiserDescriptionChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(fundraiserDescription: event.description));
  }

  void _fundraiserPageChangeEvent(FundraiserPageChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(currentIndex: event.currentIndex));
  }

  /// this method used as state change
  FundraiserState getBlocState({
    bool? loading,
    String? errMsg,
    int? currentIndex,
    String? amount,
    String? category,
    String? country,
    String? fundraiserTitle,
    String? fundraiserDescription,
    //
  }) {
    return FundraiserChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      currentIndex: currentIndex ?? state.currentIndex,
      amount: amount ?? state.amount,
      category: category ?? state.category,
      country: country ?? state.country,
      fundraiserTitle: fundraiserTitle ?? state.fundraiserTitle,
      fundraiserDescription: fundraiserDescription ?? state.fundraiserDescription,
      //
    );
  }
}

/// bloc states
@immutable
abstract class FundraiserState {
  const FundraiserState({
    required this.loading,
    required this.errMsg,
    required this.amount,
    required this.country,
    required this.category,
    required this.currentIndex,
    required this.fundraiserTitle,
    required this.fundraiserDescription,
    //
  });

  final bool loading;
  final int currentIndex;
  final String errMsg, amount, country, category;
  final String fundraiserTitle, fundraiserDescription;
}

class FundraiserChangeState extends FundraiserState {
  const FundraiserChangeState({
    required super.loading,
    required super.errMsg,
    required super.currentIndex,
    required super.amount,
    required super.category,
    required super.country,
    required super.fundraiserDescription,
    required super.fundraiserTitle,
    //
  });

  factory FundraiserChangeState.initial() => const FundraiserChangeState(
    loading: false,
    errMsg: '',
    currentIndex: 0,
    amount: '',
    category: '',
    country: '',
    fundraiserTitle: '',
    fundraiserDescription: '',
    //
  );
}

class FundraiserDraftSuccessState extends FundraiserState {
  const FundraiserDraftSuccessState({
    required super.loading,
    required super.errMsg,
    required super.currentIndex,
    required super.amount,
    required super.category,
    required super.country,
    required super.fundraiserDescription,
    required super.fundraiserTitle,
  });
}

/// bloc events
@immutable
abstract class FundraiserEvent {}

class FundraiserPageChangeEvent extends FundraiserEvent {
  final int currentIndex;

  FundraiserPageChangeEvent({required this.currentIndex});
}

class FundraiserAmountChangeEvent extends FundraiserEvent {
  final String amount;

  FundraiserAmountChangeEvent({required this.amount});
}

class FundraiserCategoryChangeEvent extends FundraiserEvent {
  final String category;

  FundraiserCategoryChangeEvent({required this.category});
}

class FundraiserCountryChangeEvent extends FundraiserEvent {
  final String country;

  FundraiserCountryChangeEvent({required this.country});
}

class FundraiserTitleChangeEvent extends FundraiserEvent {
  final String title;

  FundraiserTitleChangeEvent({required this.title});
}

class FundraiserDescriptionChangeEvent extends FundraiserEvent {
  final String description;

  FundraiserDescriptionChangeEvent({required this.description});
}

class CreateFundraiserDraftEvent extends FundraiserEvent {}
