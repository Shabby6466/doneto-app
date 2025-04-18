part of 'repository.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  RepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

}
