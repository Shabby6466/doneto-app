part of 'repository.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final LocalDataSource localDataSource;
  final FirebaseService firebaseAuthService;
  final FireStoreService fireStoreService;
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.localDataSource, required this.fireStoreService, required this.firebaseAuthService, required this.remoteDataSource});

  @override
  Future<GoogleAuthOutputs> googleAuth(GoogleAuthInput params) {
    return remoteDataSource.googleAuth(params);
  }

  @override
  Future<bool> saveToken(String params) {
    return localDataSource.saveToken(params);
  }

  @override
  Future<String> getAuthToken(NoParams params) {
    return localDataSource.getToken(R.storageKeys.authToken);
  }

  @override
  Future<bool> deleteAll() {
    return localDataSource.deleteAll();
  }

  @override
  Future<UserCredential?> signInWithEmail(String email, String password) {
    return firebaseAuthService.signInWithEmail(email, password);
  }

  @override
  Future<UserCredential?> signUpWithEmail(String email, String password) {
    return firebaseAuthService.signUpWithEmail(email, password);
  }

  @override
  Future<String> createFundraiserDraft(Fundraiser draft) {
    return fireStoreService.createFundraiserDraft(draft);
  }

  @override
  Future<Fundraiser> getFundraiserById(String id) {
    return fireStoreService.getFundraiserById(id);
  }

  @override
  Future<void> updateFundraiser(Fundraiser updated) {
    return fireStoreService.updateFundraiser(updated);
  }

  @override
  Stream<List<Fundraiser>> watchMyFundraisers(NoParams params) {
    return fireStoreService.watchMyFundraisers();
  }

  @override
  Stream<List<Fundraiser>> watchAllFundraisers(NoParams params) {
    return fireStoreService.watchAllFundraisers();
  }

  @override
  Future<UserProfile> getUserProfile(NoParams params) {
    return fireStoreService.getUserProfile();
  }

  @override
  Future<void> saveUserProfile(UserProfile draft) {
    return fireStoreService.saveUserProfile(draft);
  }

  @override
  Stream<UserProfile> watchUserProfile(String uid) {
    return fireStoreService.watchUserProfile(uid);
  }

  @override
  Future<UserProfile> getUserByIdProfile(String userId) {
    return fireStoreService.getUserByIdProfile(userId);
  }

  @override
  Stream<List<Fundraiser>> getFundraiserByCity(String city) {
    return fireStoreService.getFundraiserByCity(city);
  }
}
