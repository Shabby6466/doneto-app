part of 'repository.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  RepositoryImpl({
    required this.localDataSource,
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
}
