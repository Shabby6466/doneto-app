
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/auth/usecase/google_auth_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:doneto/core/services/datasources/local_data_source/local_data_source.dart';
import 'package:doneto/core/services/datasources/remote_data_source/remote_data_source.dart';

part 'repository_imp.dart';

abstract class Repository {
  ///* this method is used to pick Image From Gallery
  ///
   Future<GoogleAuthOutputs> googleAuth(GoogleAuthInput params);

   Future<bool> saveToken(String params);

   Future<String> getAuthToken(NoParams params);

   Future<bool> deleteAll();
  
}
