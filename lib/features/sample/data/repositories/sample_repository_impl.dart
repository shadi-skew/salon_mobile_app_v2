import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salon_mobile_app_v2/core/api/fake_api_service.dart';
import 'package:salon_mobile_app_v2/core/config/app_config.dart';
import 'package:salon_mobile_app_v2/core/errors/network_exceptions.dart';
import 'package:salon_mobile_app_v2/core/network/network_info.dart';
import 'package:salon_mobile_app_v2/features/sample/data/data_sources/sample_remote_data_source.dart';
import 'package:salon_mobile_app_v2/features/sample/data/models/sample_item_model.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/repositories/sample_repository.dart';

/// Implementation of SampleRepository
/// Falls back to fake API in development or when real API fails
@Singleton(as: SampleRepository)
class SampleRepositoryImpl implements SampleRepository {
  SampleRepositoryImpl(
    this._networkInfo,
    this._remoteDataSource,
    this._fakeApiService,
  );

  final NetworkInfo _networkInfo;
  final SampleRemoteDataSource _remoteDataSource;
  final FakeApiService _fakeApiService;

  @override
  Future<Either<NetworkExceptions, List<SampleItem>>> getSampleItems() async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getSampleItems();
        final entities = models.map((model) => model.toEntity()).toList();
        return Right(entities);
      } on Exception catch (e) {
        final exception = NetworkExceptions.getException(e);

        if (AppConfig.isDevelopment) {
          try {
            final fakeData = await _fakeApiService.getSampleItems();
            final models = fakeData
                .map((item) => SampleItemModel.fromJson(item))
                .toList();
            final entities = models.map((model) => model.toEntity()).toList();
            return Right(entities);
          } catch (_) {
            return Left(exception);
          }
        }

        return Left(exception);
      }
    } else {
      if (AppConfig.isDevelopment) {
        try {
          final fakeData = await _fakeApiService.getSampleItems();
          final models = fakeData
              .map((item) => SampleItemModel.fromJson(item))
              .toList();
          final entities = models.map((model) => model.toEntity()).toList();
          return Right(entities);
        } catch (_) {
          return const Left(NetworkExceptions.noInternetConnection());
        }
      }
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, SampleItem>> getSampleItemById(
    String id,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _remoteDataSource.getSampleItemById(id);
        return Right(model.toEntity());
      } on Exception catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, SampleItem>> createSampleItem(
    SampleItem item,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = SampleItemModel.fromEntity(item);
        final createdModel = await _remoteDataSource.createSampleItem(model);
        return Right(createdModel.toEntity());
      } on Exception catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, SampleItem>> updateSampleItem(
    SampleItem item,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = SampleItemModel.fromEntity(item);
        final updatedModel = await _remoteDataSource.updateSampleItem(model);
        return Right(updatedModel.toEntity());
      } on Exception catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }

  @override
  Future<Either<NetworkExceptions, void>> deleteSampleItem(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deleteSampleItem(id);
        return const Right(null);
      } on Exception catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
