import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTokenUseCase extends UseCase<NoParams, String> {
  final Repository repository;

  GetTokenUseCase({required this.repository});

  @override
  Future<String> call(NoParams params) {
    return repository.getAuthToken(params);
  }
}
