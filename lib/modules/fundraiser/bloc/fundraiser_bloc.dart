import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/services/firebase_service/firebase_auth_service.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/auth/usecase/save_token_usecase.dart';
import 'package:doneto/modules/fundraiser/usecases/create_fundraiser_draft_usecase.dart';
import 'package:doneto/modules/fundraiser/usecases/get_my_fundraisers_useCase.dart';
import 'package:doneto/modules/fundraiser/usecases/save_user_profile_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class FundraiserBloc extends Bloc<FundraiserEvent, FundraiserState> {
  FundraiserBloc({
    required this.createFundraiserDraftUseCase,
    required this.saveUserProfileUsecase,
    required this.saveTokenUseCase,
    required this.getMyFundraisersUseCase,
    //
  }) : super(FundraiserChangeState.initial()) {
    on<FundraiserPageChangeEvent>(_fundraiserPageChangeEvent);
    on<FundraiserAmountChangeEvent>(_amountChangeEvent);
    on<FundraiserCountryChangeEvent>(_countryChangeEvent);
    on<FundraiserCategoryChangeEvent>(_categoryChangeEvent);
    on<FundraiserDescriptionChangeEvent>(_descriptionChangeEvent);
    on<FundraiserTitleChangeEvent>(_titleChangeEvent);
    on<CreateFundraiserDraftEvent>(_createFundraiserDraft);
    on<FundraiserMediaUploadedEvent>(_uploadImage);
    on<ProfileNameChangeEvent>(_profileNameChange);
    on<PhoneNumberChangeEvent>(_phoneNumberChange);
    on<InstagramLinkChangeEvent>(_instagramLinkChange);
    on<CreateUserProfileEvent>(_saveUserProfile);
    on<EmailChangeEvent>(_emailChange);
  }

  final CreateFundraiserDraftUseCase createFundraiserDraftUseCase;
  final SaveUserProfileUsecase saveUserProfileUsecase;
  final GetMyFundraisersUseCase getMyFundraisersUseCase;
  final SaveTokenUseCase saveTokenUseCase;

  void _uploadImage(FundraiserMediaUploadedEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(imageUrl: event.mediaUrl));
  }

  void _emailChange(EmailChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(email: event.email));
  }

  Future<void> _saveUserProfile(CreateUserProfileEvent event, Emitter<FundraiserState> emit) async {
    try {
      final userId = sl<FirebaseAuth>().currentUser;
      await userId?.reload();
      emit(getBlocState(loading: true));
      final service = sl<FirebaseService>();
      final user = await service.getCurrentUser();
      await saveUserProfileUsecase.call(
        UserProfile(
          uid: user!.uid,
          fullName: state.profileName,
          email: state.email,
          phoneNumber: state.phoneNumber,
          imageUrl: state.imageUrl,
          instagramHandle: state.instaLink,
          //
        ),
      );
      await saveTokenUseCase.call(user.uid);
      emit(
        CreateProfileSuccessState(
          loading: state.loading,
          errMsg: state.errMsg,
          currentIndex: state.currentIndex,
          amount: state.amount,
          email: state.email,
          draftId: state.draftId,
          category: state.category,
          country: state.country,
          fundraiserDescription: state.fundraiserDescription,
          fundraiserTitle: state.fundraiserTitle,
          imageUrl: state.imageUrl,
          phoneNumber: state.phoneNumber,
          instaLink: state.instaLink,
          profileName: state.profileName,
        ),
      );
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  Future<void> _createFundraiserDraft(CreateFundraiserDraftEvent event, Emitter<FundraiserState> emit) async {
    try {
      emit(getBlocState(loading: true));
      final service = sl<FirebaseService>();
      final user = await service.getCurrentUser();
      sl<Logger>().f('USER FIREBASE | $user');
      final draftId = await createFundraiserDraftUseCase.call(
        Fundraiser(
          id: '',
          ownerId: user!.uid,
          supporters: 0,
          type: FundraiserType.charity,
          featured: false,
          donetoVerified: false,
          receivedAmount: 0,
          targetAmount: double.tryParse(state.amount) ?? 0.0,
          location: state.country,
          category: state.category,
          photoUrl: state.imageUrl,
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
          email: state.email,
          draftId: draftId,
          amount: state.amount,
          category: state.category,
          country: state.country,
          fundraiserDescription: state.fundraiserDescription,
          imageUrl: state.imageUrl,
          fundraiserTitle: state.fundraiserTitle,
          phoneNumber: state.phoneNumber,
          instaLink: state.instaLink,
          profileName: state.profileName,
          //
        ),
      );
    } on DefaultFailure catch (e) {
      emit(getBlocState(loading: false, errMsg: e.message));
    }
  }

  void _categoryChangeEvent(event, Emitter<FundraiserState> emit) {
    emit(getBlocState(category: event.category));
  }

  void _instagramLinkChange(InstagramLinkChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(instaLink: event.instaLink));
  }

  void _amountChangeEvent(FundraiserAmountChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(amount: event.amount));
  }

  void _profileNameChange(ProfileNameChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(profileName: event.profile));
  }

  void _phoneNumberChange(PhoneNumberChangeEvent event, Emitter<FundraiserState> emit) {
    emit(getBlocState(phoneNumber: event.phoneNumber));
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
    String? draftId,
    String? fundraiserDescription,
    String? imageUrl,
    String? phoneNumber,
    String? instaLink,
    String? profileName,
    String? email,
    //
  }) {
    return FundraiserChangeState(
      email: errMsg ?? state.email,
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      currentIndex: currentIndex ?? state.currentIndex,
      amount: amount ?? state.amount,
      imageUrl: imageUrl ?? state.imageUrl,
      draftId: draftId ?? state.draftId,
      category: category ?? state.category,
      country: country ?? state.country,
      fundraiserTitle: fundraiserTitle ?? state.fundraiserTitle,
      fundraiserDescription: fundraiserDescription ?? state.fundraiserDescription,
      instaLink: instaLink ?? state.instaLink,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      profileName: profileName ?? state.profileName,
      //
    );
  }
}

/// bloc states
@immutable
abstract class FundraiserState {
  const FundraiserState({
    required this.loading,
    required this.draftId,
    required this.errMsg,
    required this.amount,
    required this.country,
    required this.category,
    required this.currentIndex,
    required this.fundraiserTitle,
    required this.imageUrl,
    required this.fundraiserDescription,
    required this.phoneNumber,
    required this.instaLink,
    required this.email,
    required this.profileName,
    //
  });

  final bool loading;
  final int currentIndex;
  final String errMsg, amount, country, category, imageUrl, profileName, phoneNumber, instaLink;
  final String fundraiserTitle, fundraiserDescription, draftId, email;
}

class FundraiserChangeState extends FundraiserState {
  const FundraiserChangeState({
    required super.loading,
    required super.phoneNumber,
    required super.instaLink,
    required super.profileName,
    required super.errMsg,
    required super.draftId,
    required super.email,
    required super.currentIndex,
    required super.amount,
    required super.category,
    required super.country,
    required super.fundraiserDescription,
    required super.fundraiserTitle,
    required super.imageUrl,
    //
  });

  factory FundraiserChangeState.initial() => const FundraiserChangeState(
    loading: false,
    errMsg: '',
    currentIndex: 0,
    amount: '',
    category: '',
    country: '',
    draftId: '',
    fundraiserTitle: '',
    email: '',
    fundraiserDescription: '',
    imageUrl: '',
    phoneNumber: '',
    instaLink: '',
    profileName: '',
    //
  );
}

class FundraiserDraftSuccessState extends FundraiserState {
  const FundraiserDraftSuccessState({
    required super.loading,
    required super.errMsg,
    required super.currentIndex,
    required super.amount,
    required super.draftId,
    required super.category,
    required super.country,
    required super.fundraiserDescription,
    required super.fundraiserTitle,
    required super.imageUrl,
    required super.email,
    required super.phoneNumber,
    required super.instaLink,
    required super.profileName,
  });
}

class CreateProfileSuccessState extends FundraiserState {
  const CreateProfileSuccessState({
    required super.loading,
    required super.errMsg,
    required super.currentIndex,
    required super.amount,
    required super.email,
    required super.draftId,
    required super.category,
    required super.country,
    required super.fundraiserDescription,
    required super.fundraiserTitle,
    required super.imageUrl,
    required super.phoneNumber,
    required super.instaLink,
    required super.profileName,
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

class ProfileNameChangeEvent extends FundraiserEvent {
  final String profile;

  ProfileNameChangeEvent({required this.profile});
}

class PhoneNumberChangeEvent extends FundraiserEvent {
  final String phoneNumber;

  PhoneNumberChangeEvent({required this.phoneNumber});
}

class InstagramLinkChangeEvent extends FundraiserEvent {
  final String instaLink;

  InstagramLinkChangeEvent({required this.instaLink});
}

class FundraiserTitleChangeEvent extends FundraiserEvent {
  final String title;

  FundraiserTitleChangeEvent({required this.title});
}

class FundraiserDescriptionChangeEvent extends FundraiserEvent {
  final String description;

  FundraiserDescriptionChangeEvent({required this.description});
}

class EmailChangeEvent extends FundraiserEvent {
  final String email;

  EmailChangeEvent({required this.email});
}

class CreateFundraiserDraftEvent extends FundraiserEvent {}

class FundraiserMediaUploadedEvent extends FundraiserEvent {
  final String mediaUrl;

  FundraiserMediaUploadedEvent({required this.mediaUrl});
}

class CreateUserProfileEvent extends FundraiserEvent {}

class GetMyFundraiserEvent extends FundraiserEvent {}
