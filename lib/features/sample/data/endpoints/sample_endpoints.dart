import 'package:salon_mobile_app_v2/core/config/app_config.dart';

/// Endpoints for the Sample feature
class SampleEndpoints {
  SampleEndpoints._();

  static String get baseUrl => AppConfig.baseUrl;

  /// Get all sample items
  static String get getSampleItems => '$baseUrl/sample-items';

  /// Get a single sample item by ID
  static String getSampleItemById(String id) => '$baseUrl/sample-items/$id';

  /// Create a new sample item
  static String get createSampleItem => '$baseUrl/sample-items';

  /// Update an existing sample item
  static String updateSampleItem(String id) => '$baseUrl/sample-items/$id';

  /// Delete a sample item
  static String deleteSampleItem(String id) => '$baseUrl/sample-items/$id';
}
