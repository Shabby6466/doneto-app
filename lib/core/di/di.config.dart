// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:doneto/core/di/register_modules.dart' as _i159;
import 'package:doneto/core/network_calls/dio_wrapper/index.dart' as _i966;
import 'package:doneto/core/network_calls/injector/dio_injector.dart' as _i949;
import 'package:doneto/core/services/datasources/local_data_source/local_data_source.dart'
    as _i803;
import 'package:doneto/core/services/datasources/remote_data_source/remote_data_source.dart'
    as _i213;
import 'package:doneto/core/services/firebase_service/firebase_auth_service.dart'
    as _i594;
import 'package:doneto/core/services/firebase_service/firestore_service.dart'
    as _i780;
import 'package:doneto/core/services/permissions/permission_engine.dart'
    as _i524;
import 'package:doneto/core/services/permissions/permission_service.dart'
    as _i671;
import 'package:doneto/core/services/repository/repository.dart' as _i578;
import 'package:doneto/core/utils/go_router/routes_navigation.dart' as _i11;
import 'package:doneto/modules/auth/usecase/delete_token_usecase.dart' as _i694;
import 'package:doneto/modules/auth/usecase/get_token_usecase.dart' as _i398;
import 'package:doneto/modules/auth/usecase/google_auth_usecase.dart' as _i730;
import 'package:doneto/modules/auth/usecase/save_token_usecase.dart' as _i610;
import 'package:doneto/modules/fundraiser/usecases/create_fundraiser_draft_usecase.dart'
    as _i286;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:intl/intl.dart' as _i602;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.lazySingleton<_i974.Logger>(() => registerModule.logger);
    gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i602.NumberFormat>(() => registerModule.numberFormat);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => registerModule.firebaseFirestore,
    );
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i671.PermissionService>(
      () => _i671.PermissionsServiceImp(),
    );
    gh.singleton<_i594.FirebaseService>(
      () => _i594.FirebaseServiceImp(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i966.ErrorHandler>(() => _i966.ErrorHandlerImpl());
    gh.lazySingleton<_i780.FireStoreService>(
      () => _i780.FirebaseServiceImp(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i966.HttpApiCalls>(
      () => _i966.DioWrapperImpl(
        dio: gh<_i361.Dio>(),
        logger: gh<_i974.Logger>(),
        errorHandler: gh<_i966.ErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i213.RemoteDataSource>(
      () => _i213.RemoteDataSourceImp(
        networkCallsWrapper: gh<_i966.HttpApiCalls>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i11.Navigation>(() => _i11.NavigationImpl());
    gh.lazySingletonAsync<_i803.LocalDataSource>(
      () async => _i803.LocalDataSourceImpl(
        sharedPreferences: await getAsync<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingletonAsync<_i578.Repository>(
      () async => _i578.RepositoryImpl(
        localDataSource: await getAsync<_i803.LocalDataSource>(),
        fireStoreService: gh<_i780.FireStoreService>(),
        firebaseAuthService: gh<_i594.FirebaseService>(),
        remoteDataSource: gh<_i213.RemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i524.PermissionEngine>(
      () => _i524.PermissionEngineImp(gh<_i671.PermissionService>()),
    );
    gh.singletonAsync<_i730.GoogleAuthUseCase>(
      () async => _i730.GoogleAuthUseCase(
        repository: await getAsync<_i578.Repository>(),
      ),
    );
    gh.singletonAsync<_i694.DeleteTokenUseCase>(
      () async => _i694.DeleteTokenUseCase(
        repository: await getAsync<_i578.Repository>(),
      ),
    );
    gh.singletonAsync<_i610.SaveTokenUseCase>(
      () async => _i610.SaveTokenUseCase(
        repository: await getAsync<_i578.Repository>(),
      ),
    );
    gh.singletonAsync<_i398.GetTokenUseCase>(
      () async =>
          _i398.GetTokenUseCase(repository: await getAsync<_i578.Repository>()),
    );
    gh.singletonAsync<_i286.CreateFundraiserDraftUseCase>(
      () async => _i286.CreateFundraiserDraftUseCase(
        repository: await getAsync<_i578.Repository>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i159.RegisterModule {}

class _$DioModule extends _i949.DioModule {}
