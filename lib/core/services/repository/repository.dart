import 'package:doneto/core/services/firebase_service/firestore_service.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/auth/usecase/google_auth_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:doneto/core/services/datasources/local_data_source/local_data_source.dart';
import 'package:doneto/core/services/datasources/remote_data_source/remote_data_source.dart';
import '../firebase_service/firebase_auth_service.dart';

part 'repository_imp.dart';

abstract class Repository {
  ///* this method is used to pick Image From Gallery
  ///
  Future<GoogleAuthOutputs> googleAuth(GoogleAuthInput params);

  Future<bool> saveToken(String params);

  Future<String> getAuthToken(NoParams params);

  Future<bool> deleteAll();

  Future<UserCredential?> signInWithEmail(String email, String password);

  Future<UserCredential?> signUpWithEmail(String email, String password);

  Future<String> createFundraiserDraft(Fundraiser draft);

  Future<void> updateFundraiser(Fundraiser updated);

  Future<Fundraiser> getFundraiserById(String id);

  Stream<List<Fundraiser>> watchMyFundraisers(NoParams params);

  Stream<List<Fundraiser>> watchAllFundraisers(NoParams params);

  Future<void> saveUserProfile(UserProfile draft);

  Future<UserProfile> getUserProfile(NoParams params);

  Stream<UserProfile> watchUserProfile(String uid);

  Future<UserProfile> getUserByIdProfile(String userId);

  Stream<List<Fundraiser>> getFundraiserByCity(String city);
}
