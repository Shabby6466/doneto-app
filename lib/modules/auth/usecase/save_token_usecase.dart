import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class SaveTokenUseCase extends UseCase<String, bool> {
  final Repository repository;

  SaveTokenUseCase({required this.repository});

  @override
  Future<bool> call(String params) {
    return repository.saveToken(params);
  }
}
