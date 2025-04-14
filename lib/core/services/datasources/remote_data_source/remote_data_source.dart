import 'package:injectable/injectable.dart';

part 'remote_data_source_imp.dart';

abstract class RemoteDataSource {
}

abstract class ApiParams {
  Map<String, dynamic> toJson();
}
