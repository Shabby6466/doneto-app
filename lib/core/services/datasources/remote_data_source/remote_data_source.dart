import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:doneto/core/utils/resource/r.dart';

part 'remote_data_source_imp.dart';

abstract class RemoteDataSource {
}

abstract class ApiParams {
  Map<String, dynamic> toJson();
}
