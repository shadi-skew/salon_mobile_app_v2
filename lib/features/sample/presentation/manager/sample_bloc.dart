import 'package:bloc/bloc.dart';
import 'package:salon_mobile_app_v2/core/use_case/use_case.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/entities/sample_item.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/use_cases/get_sample_items_usecase.dart';
import 'package:salon_mobile_app_v2/features/sample/presentation/manager/sample_event.dart';
import 'package:salon_mobile_app_v2/features/sample/presentation/manager/sample_state.dart';

/// BLoC for sample feature
/// Handles business logic and state management
/// Registered in bloc_injection.dart
class SampleBloc extends Bloc<SampleEvent, SampleState> {
  SampleBloc(this._getSampleItemsUseCase) : super(const SampleState.initial()) {
    on<SampleEvent>(_onEvent);
  }

  final GetSampleItemsUseCase _getSampleItemsUseCase;

  // Cache to track last loaded data
  List<SampleItem>? _cachedItems;
  DateTime? _lastLoadTime;
  static const _cacheValidityDuration = Duration(minutes: 5);

  Future<void> _onEvent(
    SampleEvent event,
    Emitter<SampleState> emit,
  ) async {
    await event.when(
      loadItems: () => _onLoadItems(emit, forceRefresh: false),
      refreshItems: () => _onLoadItems(emit, forceRefresh: true),
      createItem: (_) async {},
      updateItem: (_) async {},
      deleteItem: (_) async {},
    );
  }

  /// Load items with optional force refresh
  Future<void> _onLoadItems(
    Emitter<SampleState> emit, {
    required bool forceRefresh,
  }) async {
    if (!forceRefresh && _shouldUseCache()) {
      if (_cachedItems != null) {
        emit(SampleState.success(items: _cachedItems!));
        return;
      }
    }

    if (_cachedItems == null) {
      emit(const SampleState.loading());
    }

    final result = await _getSampleItemsUseCase(NoParams());

    result.fold(
      (error) => emit(SampleState.error(error)),
      (items) {
        _cachedItems = items;
        _lastLoadTime = DateTime.now();
        emit(SampleState.success(items: items));
      },
    );
  }

  bool _shouldUseCache() {
    if (_cachedItems == null || _lastLoadTime == null) {
      return false;
    }

    final now = DateTime.now();
    final timeSinceLastLoad = now.difference(_lastLoadTime!);

    return timeSinceLastLoad < _cacheValidityDuration;
  }

  void invalidateCache() {
    _cachedItems = null;
    _lastLoadTime = null;
  }
}
