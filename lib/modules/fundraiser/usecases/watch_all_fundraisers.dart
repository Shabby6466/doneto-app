import 'package:doneto/core/services/repository/repository.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class WatchAllFundraisersUseCase extends UseCase<NoParams, Stream<List<Fundraiser>>> {
  final Repository repository;

  WatchAllFundraisersUseCase({required this.repository});

  Stream<List<Fundraiser>> calling(NoParams params) {
    return repository.watchAllFundraisers(params);
  }

  @override
  Future<Stream<List<Fundraiser>>> call(NoParams params) {
    throw UnimplementedError();
  }
}
