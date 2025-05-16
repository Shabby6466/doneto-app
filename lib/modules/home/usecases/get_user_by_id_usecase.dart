import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetUserByIdUseCase extends UseCase<String, UserProfile> {
  final Repository repository;

  GetUserByIdUseCase({required this.repository});

  @override
  Future<UserProfile> call(String params) async {
    return await repository.getUserByIdProfile(params);
  }
}
