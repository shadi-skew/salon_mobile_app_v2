import 'package:dartz/dartz.dart';
import 'package:salon_mobile_app_v2/core/errors/network_exceptions.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';

/// Repository interface for sample feature
/// This defines the contract that data layer must implement
abstract class SampleRepository {
  /// Get all sample items
  Future<Either<NetworkExceptions, List<SampleItem>>> getSampleItems();

  /// Get a single sample item by id
  Future<Either<NetworkExceptions, SampleItem>> getSampleItemById(String id);

  /// Create a new sample item
  Future<Either<NetworkExceptions, SampleItem>> createSampleItem(
    SampleItem item,
  );

  /// Update an existing sample item
  Future<Either<NetworkExceptions, SampleItem>> updateSampleItem(
    SampleItem item,
  );

  /// Delete a sample item
  Future<Either<NetworkExceptions, void>> deleteSampleItem(String id);
}
