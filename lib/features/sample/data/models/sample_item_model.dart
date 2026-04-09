import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';

/// Data model for SampleItem
/// This is a data layer representation with JSON serialization capabilities
class SampleItemModel {
  const SampleItemModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  /// Create model from JSON
  factory SampleItemModel.fromJson(Map<String, dynamic> json) {
    return SampleItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  /// Convert to domain entity
  SampleItem toEntity() {
    return SampleItem(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }

  /// Create from domain entity
  factory SampleItemModel.fromEntity(SampleItem entity) {
    return SampleItemModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }
}
