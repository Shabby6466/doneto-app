import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class SaveUserProfileUsecase extends UseCase<UserProfile, void> {
  final Repository repository;

  SaveUserProfileUsecase({required this.repository});

  @override
  Future<void> call(UserProfile params) async {
    return await repository.saveUserProfile(params);
  }
}
