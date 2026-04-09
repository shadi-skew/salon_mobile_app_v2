// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'core/api/api_consumer.dart' as _i962;
import 'core/api/dio_consumer.dart' as _i737;
import 'core/api/fake_api_service.dart' as _i685;
import 'core/api/interceptors/auth_interceptor.dart' as _i240;
import 'core/api/interceptors/error_interceptor.dart' as _i809;
import 'core/api/interceptors/logging_interceptor.dart' as _i416;
import 'core/di/bloc_injection.dart' as _i732;
import 'core/di/third_party_injection.dart' as _i1007;
import 'core/network/network_info.dart' as _i75;
import 'features/sample/data/data_sources/sample_remote_data_source.dart'
    as _i458;
import 'features/sample/data/repositories/sample_repository_impl.dart'
    as _i1046;
import 'features/sample/domain/repositories/sample_repository.dart' as _i21;
import 'features/sample/domain/use_cases/get_sample_items_usecase.dart'
    as _i303;
import 'features/sample/presentation/manager/sample_bloc.dart' as _i681;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyInjection = _$ThirdPartyInjection();
    final blocInjection = _$BlocInjection();
    gh.singleton<_i361.Dio>(() => thirdPartyInjection.dio);
    gh.singleton<_i973.InternetConnectionChecker>(
      () => thirdPartyInjection.internetConnectionChecker,
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => thirdPartyInjection.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i809.ErrorInterceptor>(() => _i809.ErrorInterceptor());
    gh.singleton<_i416.LoggingInterceptor>(() => _i416.LoggingInterceptor());
    gh.singleton<_i685.FakeApiService>(() => _i685.FakeApiService());
    gh.lazySingleton<_i75.NetworkInfo>(
      () => _i75.NetworkInfoImpl(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i240.AuthInterceptor>(
      () => _i240.AuthInterceptor(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i962.ApiConsumer>(
      () => _i737.DioConsumer(
        gh<_i361.Dio>(),
        gh<_i240.AuthInterceptor>(),
        gh<_i809.ErrorInterceptor>(),
        gh<_i416.LoggingInterceptor>(),
      ),
    );
    gh.singleton<_i458.SampleRemoteDataSource>(
      () => _i458.SampleRemoteDataSource(gh<_i962.ApiConsumer>()),
    );
    gh.singleton<_i21.SampleRepository>(
      () => _i1046.SampleRepositoryImpl(
        gh<_i75.NetworkInfo>(),
        gh<_i458.SampleRemoteDataSource>(),
        gh<_i685.FakeApiService>(),
      ),
    );
    gh.factory<_i303.GetSampleItemsUseCase>(
      () => _i303.GetSampleItemsUseCase(gh<_i21.SampleRepository>()),
    );
    gh.singleton<_i681.SampleBloc>(
      () => blocInjection.sampleBloc(gh<_i303.GetSampleItemsUseCase>()),
    );
    return this;
  }
}

class _$ThirdPartyInjection extends _i1007.ThirdPartyInjection {}

class _$BlocInjection extends _i732.BlocInjection {}
