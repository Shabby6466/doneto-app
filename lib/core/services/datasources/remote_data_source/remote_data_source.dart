import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/auth/usecase/google_auth_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'remote_data_source_imp.dart';

abstract class RemoteDataSource {
  Future<GoogleAuthOutputs> googleAuth(GoogleAuthInput params);
}

abstract class ApiParams {
  Map<String, dynamic> toJson();
}
