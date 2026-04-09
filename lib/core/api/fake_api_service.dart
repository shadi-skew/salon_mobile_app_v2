import 'dart:math';
import 'package:injectable/injectable.dart';

/// Fake API Service for development and testing
/// Returns mock data to simulate API responses
@singleton
class FakeApiService {
  FakeApiService();

  final Random _random = Random();

  /// Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(1000)));
  }

  /// Get fake sample items
  Future<List<Map<String, dynamic>>> getSampleItems() async {
    await _simulateDelay();

    if (_random.nextDouble() < 0.1) {
      throw Exception('Simulated network error');
    }

    return List.generate(10, (index) => {
      'id': 'item_${index + 1}',
      'title': 'Sample Item ${index + 1}',
      'description': 'This is a description for sample item ${index + 1}.',
      'isCompleted': _random.nextBool(),
    });
  }

  /// Get fake sample item by ID
  Future<Map<String, dynamic>> getSampleItemById(String id) async {
    await _simulateDelay();

    return {
      'id': id,
      'title': 'Sample Item $id',
      'description': 'Detailed description for item $id',
      'isCompleted': false,
    };
  }

  /// Create fake sample item
  Future<Map<String, dynamic>> createSampleItem(Map<String, dynamic> item) async {
    await _simulateDelay();

    return {
      'id': 'item_${DateTime.now().millisecondsSinceEpoch}',
      'title': item['title'] ?? 'New Item',
      'description': item['description'] ?? '',
      'isCompleted': item['isCompleted'] ?? false,
    };
  }

  /// Update fake sample item
  Future<Map<String, dynamic>> updateSampleItem(String id, Map<String, dynamic> item) async {
    await _simulateDelay();

    return {
      'id': id,
      'title': item['title'] ?? 'Updated Item',
      'description': item['description'] ?? '',
      'isCompleted': item['isCompleted'] ?? false,
    };
  }

  /// Delete fake sample item
  Future<void> deleteSampleItem(String id) async {
    await _simulateDelay();
  }
}
