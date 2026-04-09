import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salon_mobile_app_v2/core/errors/network_exceptions.dart';
import 'package:salon_mobile_app_v2/core/use_case/use_case.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/repositories/sample_repository.dart';

/// Use case for getting all sample items
@injectable
class GetSampleItemsUseCase implements UseCase<List<SampleItem>, NoParams> {
  GetSampleItemsUseCase(this._repository);

  final SampleRepository _repository;

  @override
  Future<Either<NetworkExceptions, List<SampleItem>>> call(
    NoParams params,
  ) async {
    return await _repository.getSampleItems();
  }
}
