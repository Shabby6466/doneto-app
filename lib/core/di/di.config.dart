// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:doneto/core/di/register_modules.dart' as _i159;
import 'package:doneto/core/network_calls/dio_wrapper/index.dart' as _i966;
import 'package:doneto/core/network_calls/injector/dio_injector.dart' as _i949;
import 'package:doneto/core/services/datasources/local_data_source/local_data_source.dart'
    as _i803;
import 'package:doneto/core/services/datasources/remote_data_source/remote_data_source.dart'
    as _i213;
import 'package:doneto/core/services/permissions/permission_engine.dart'
    as _i524;
import 'package:doneto/core/services/permissions/permission_service.dart'
    as _i671;
import 'package:doneto/core/services/repository/repository.dart' as _i578;
import 'package:doneto/core/utils/go_router/routes_navigation.dart' as _i11;
import 'package:get_it/get_it.dart' as _i174;
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
    gh.lazySingleton<_i602.NumberFormat>(() => registerModule.numberFormat);
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i671.PermissionService>(
      () => _i671.PermissionsServiceImp(),
    );
    gh.lazySingleton<_i966.ErrorHandler>(() => _i966.ErrorHandlerImpl());
    gh.lazySingleton<_i966.HttpApiCalls>(
      () => _i966.DioWrapperImpl(
        dio: gh<_i361.Dio>(),
        logger: gh<_i974.Logger>(),
        errorHandler: gh<_i966.ErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i213.RemoteDataSource>(() => _i213.RemoteDataSourceImp());
    gh.singleton<_i11.Navigation>(() => _i11.NavigationImpl());
    gh.lazySingletonAsync<_i803.LocalDataSource>(
      () async => _i803.LocalDataSourceImpl(
        sharedPreferences: await getAsync<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i524.PermissionEngine>(
      () => _i524.PermissionEngineImp(gh<_i671.PermissionService>()),
    );
    gh.lazySingletonAsync<_i578.Repository>(
      () async => _i578.RepositoryImpl(
        localDataSource: await getAsync<_i803.LocalDataSource>(),
        remoteDataSource: gh<_i213.RemoteDataSource>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i159.RegisterModule {}

class _$DioModule extends _i949.DioModule {}
