import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:salon_mobile_app_v2/core/errors/network_exceptions.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';

part 'sample_state.freezed.dart';

/// State for sample feature
/// Uses freezed for immutable state management
@freezed
class SampleState with _$SampleState {
  const factory SampleState.initial() = _Initial;
  const factory SampleState.loading() = _Loading;
  const factory SampleState.success({
    required List<SampleItem> items,
  }) = _Success;
  const factory SampleState.error(NetworkExceptions error) = _Error;
}
