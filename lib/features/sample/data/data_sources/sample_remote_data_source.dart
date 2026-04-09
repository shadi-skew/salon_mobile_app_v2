import 'package:injectable/injectable.dart';
import 'package:salon_mobile_app_v2/core/api/api_consumer.dart';
import 'package:salon_mobile_app_v2/features/sample/data/endpoints/sample_endpoints.dart';
import 'package:salon_mobile_app_v2/features/sample/data/models/sample_item_model.dart';

/// Remote data source for sample feature
/// Handles API calls for sample items
@singleton
class SampleRemoteDataSource {
  SampleRemoteDataSource(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  /// Get all sample items from API
  Future<List<SampleItemModel>> getSampleItems() async {
    final response = await _apiConsumer.get(
      SampleEndpoints.getSampleItems,
    );

    if (response is List) {
      return response
          .map((item) => SampleItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  /// Get a single sample item by id
  Future<SampleItemModel> getSampleItemById(String id) async {
    final response = await _apiConsumer.get(
      SampleEndpoints.getSampleItemById(id),
    );

    return SampleItemModel.fromJson(response as Map<String, dynamic>);
  }

  /// Create a new sample item
  Future<SampleItemModel> createSampleItem(SampleItemModel item) async {
    final response = await _apiConsumer.post(
      SampleEndpoints.createSampleItem,
      body: item.toJson(),
    );

    return SampleItemModel.fromJson(response as Map<String, dynamic>);
  }

  /// Update an existing sample item
  Future<SampleItemModel> updateSampleItem(SampleItemModel item) async {
    final response = await _apiConsumer.put(
      SampleEndpoints.updateSampleItem(item.id),
      body: item.toJson(),
    );

    return SampleItemModel.fromJson(response as Map<String, dynamic>);
  }

  /// Delete a sample item
  Future<void> deleteSampleItem(String id) async {
    await _apiConsumer.delete(SampleEndpoints.deleteSampleItem(id));
  }
}
