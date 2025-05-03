import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeleteTokenUseCase extends UseCase<NoParams, bool> {
  final Repository repository;

  DeleteTokenUseCase({required this.repository});

  @override
  Future<bool> call(NoParams params) {
    return repository.deleteAll();
  }
}
