import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class WatchFundraisersByCityUseCase extends UseCase<String, Stream<List<Fundraiser>>> {
  final Repository repository;

  WatchFundraisersByCityUseCase({required this.repository});

  Stream<List<Fundraiser>> calling(String params) {
    return repository.getFundraiserByCity(params);
  }

  @override
  Future<Stream<List<Fundraiser>>> call(String params) {
    throw UnimplementedError();
  }
}
