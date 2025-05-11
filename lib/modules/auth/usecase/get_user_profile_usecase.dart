import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetUserProfileUseCase extends UseCase<NoParams, UserProfile> {
  final Repository repository;

  GetUserProfileUseCase({required this.repository});

  @override
  Future<UserProfile> call(NoParams params) {
    return repository.getUserProfile(params);
  }
}
