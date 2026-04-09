import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';

part 'sample_event.freezed.dart';

/// Events for sample feature
/// Uses freezed for immutable event management
@freezed
class SampleEvent with _$SampleEvent {
  const factory SampleEvent.loadItems() = _LoadItems;
  const factory SampleEvent.refreshItems() = _RefreshItems;
  const factory SampleEvent.createItem(SampleItem item) = _CreateItem;
  const factory SampleEvent.updateItem(SampleItem item) = _UpdateItem;
  const factory SampleEvent.deleteItem(String id) = _DeleteItem;
}
