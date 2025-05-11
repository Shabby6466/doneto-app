import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/funraiser_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateFundraiserDraftUseCase extends UseCase<Fundraiser, String> {
  final Repository repository;

  CreateFundraiserDraftUseCase({required this.repository});

  @override
  Future<String> call(Fundraiser params) async {
    return await repository.createFundraiserDraft(params);
  }
}
