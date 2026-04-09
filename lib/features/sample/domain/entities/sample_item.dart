import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_item.freezed.dart';

/// Sample entity representing a data item
/// This is a pure domain entity with no dependencies on external frameworks
@freezed
class SampleItem with _$SampleItem {
  const factory SampleItem({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
  }) = _SampleItem;
}
