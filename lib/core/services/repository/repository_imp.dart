part of 'repository.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final LocalDataSource localDataSource;
  final FirebaseService firebaseAuthService;
  final RemoteDataSource remoteDataSource;
  RepositoryImpl({
    required this.localDataSource,
    required this.firebaseAuthService,
    required this.remoteDataSource,
  });

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


}
