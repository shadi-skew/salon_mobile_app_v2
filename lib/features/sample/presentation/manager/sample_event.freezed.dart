// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SampleEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function() refreshItems,
    required TResult Function(SampleItem item) createItem,
    required TResult Function(SampleItem item) updateItem,
    required TResult Function(String id) deleteItem,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function()? refreshItems,
    TResult? Function(SampleItem item)? createItem,
    TResult? Function(SampleItem item)? updateItem,
    TResult? Function(String id)? deleteItem,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function()? refreshItems,
    TResult Function(SampleItem item)? createItem,
    TResult Function(SampleItem item)? updateItem,
    TResult Function(String id)? deleteItem,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_CreateItem value) createItem,
    required TResult Function(_UpdateItem value) updateItem,
    required TResult Function(_DeleteItem value) deleteItem,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_CreateItem value)? createItem,
    TResult? Function(_UpdateItem value)? updateItem,
    TResult? Function(_DeleteItem value)? deleteItem,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_CreateItem value)? createItem,
    TResult Function(_UpdateItem value)? updateItem,
    TResult Function(_DeleteItem value)? deleteItem,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleEventCopyWith<$Res> {
  factory $SampleEventCopyWith(
    SampleEvent value,
    $Res Function(SampleEvent) then,
  ) = _$SampleEventCopyWithImpl<$Res, SampleEvent>;
}

/// @nodoc
class _$SampleEventCopyWithImpl<$Res, $Val extends SampleEvent>
    implements $SampleEventCopyWith<$Res> {
  _$SampleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadItemsImplCopyWith<$Res> {
  factory _$$LoadItemsImplCopyWith(
    _$LoadItemsImpl value,
    $Res Function(_$LoadItemsImpl) then,
  ) = __$$LoadItemsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadItemsImplCopyWithImpl<$Res>
    extends _$SampleEventCopyWithImpl<$Res, _$LoadItemsImpl>
    implements _$$LoadItemsImplCopyWith<$Res> {
  __$$LoadItemsImplCopyWithImpl(
    _$LoadItemsImpl _value,
    $Res Function(_$LoadItemsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadItemsImpl implements _LoadItems {
  const _$LoadItemsImpl();

  @override
  String toString() {
    return 'SampleEvent.loadItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function() refreshItems,
    required TResult Function(SampleItem item) createItem,
    required TResult Function(SampleItem item) updateItem,
    required TResult Function(String id) deleteItem,
  }) {
    return loadItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function()? refreshItems,
    TResult? Function(SampleItem item)? createItem,
    TResult? Function(SampleItem item)? updateItem,
    TResult? Function(String id)? deleteItem,
  }) {
    return loadItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function()? refreshItems,
    TResult Function(SampleItem item)? createItem,
    TResult Function(SampleItem item)? updateItem,
    TResult Function(String id)? deleteItem,
    required TResult orElse(),
  }) {
    if (loadItems != null) {
      return loadItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_CreateItem value) createItem,
    required TResult Function(_UpdateItem value) updateItem,
    required TResult Function(_DeleteItem value) deleteItem,
  }) {
    return loadItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_CreateItem value)? createItem,
    TResult? Function(_UpdateItem value)? updateItem,
    TResult? Function(_DeleteItem value)? deleteItem,
  }) {
    return loadItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_CreateItem value)? createItem,
    TResult Function(_UpdateItem value)? updateItem,
    TResult Function(_DeleteItem value)? deleteItem,
    required TResult orElse(),
  }) {
    if (loadItems != null) {
      return loadItems(this);
    }
    return orElse();
  }
}

abstract class _LoadItems implements SampleEvent {
  const factory _LoadItems() = _$LoadItemsImpl;
}

/// @nodoc
abstract class _$$RefreshItemsImplCopyWith<$Res> {
  factory _$$RefreshItemsImplCopyWith(
    _$RefreshItemsImpl value,
    $Res Function(_$RefreshItemsImpl) then,
  ) = __$$RefreshItemsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshItemsImplCopyWithImpl<$Res>
    extends _$SampleEventCopyWithImpl<$Res, _$RefreshItemsImpl>
    implements _$$RefreshItemsImplCopyWith<$Res> {
  __$$RefreshItemsImplCopyWithImpl(
    _$RefreshItemsImpl _value,
    $Res Function(_$RefreshItemsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshItemsImpl implements _RefreshItems {
  const _$RefreshItemsImpl();

  @override
  String toString() {
    return 'SampleEvent.refreshItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function() refreshItems,
    required TResult Function(SampleItem item) createItem,
    required TResult Function(SampleItem item) updateItem,
    required TResult Function(String id) deleteItem,
  }) {
    return refreshItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function()? refreshItems,
    TResult? Function(SampleItem item)? createItem,
    TResult? Function(SampleItem item)? updateItem,
    TResult? Function(String id)? deleteItem,
  }) {
    return refreshItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function()? refreshItems,
    TResult Function(SampleItem item)? createItem,
    TResult Function(SampleItem item)? updateItem,
    TResult Function(String id)? deleteItem,
    required TResult orElse(),
  }) {
    if (refreshItems != null) {
      return refreshItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_CreateItem value) createItem,
    required TResult Function(_UpdateItem value) updateItem,
    required TResult Function(_DeleteItem value) deleteItem,
  }) {
    return refreshItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_CreateItem value)? createItem,
    TResult? Function(_UpdateItem value)? updateItem,
    TResult? Function(_DeleteItem value)? deleteItem,
  }) {
    return refreshItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_CreateItem value)? createItem,
    TResult Function(_UpdateItem value)? updateItem,
    TResult Function(_DeleteItem value)? deleteItem,
    required TResult orElse(),
  }) {
    if (refreshItems != null) {
      return refreshItems(this);
    }
    return orElse();
  }
}

abstract class _RefreshItems implements SampleEvent {
  const factory _RefreshItems() = _$RefreshItemsImpl;
}

/// @nodoc
abstract class _$$CreateItemImplCopyWith<$Res> {
  factory _$$CreateItemImplCopyWith(
    _$CreateItemImpl value,
    $Res Function(_$CreateItemImpl) then,
  ) = __$$CreateItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SampleItem item});

  $SampleItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$CreateItemImplCopyWithImpl<$Res>
    extends _$SampleEventCopyWithImpl<$Res, _$CreateItemImpl>
    implements _$$CreateItemImplCopyWith<$Res> {
  __$$CreateItemImplCopyWithImpl(
    _$CreateItemImpl _value,
    $Res Function(_$CreateItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = null}) {
    return _then(
      _$CreateItemImpl(
        null == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as SampleItem,
      ),
    );
  }

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleItemCopyWith<$Res> get item {
    return $SampleItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$CreateItemImpl implements _CreateItem {
  const _$CreateItemImpl(this.item);

  @override
  final SampleItem item;

  @override
  String toString() {
    return 'SampleEvent.createItem(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateItemImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateItemImplCopyWith<_$CreateItemImpl> get copyWith =>
      __$$CreateItemImplCopyWithImpl<_$CreateItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function() refreshItems,
    required TResult Function(SampleItem item) createItem,
    required TResult Function(SampleItem item) updateItem,
    required TResult Function(String id) deleteItem,
  }) {
    return createItem(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function()? refreshItems,
    TResult? Function(SampleItem item)? createItem,
    TResult? Function(SampleItem item)? updateItem,
    TResult? Function(String id)? deleteItem,
  }) {
    return createItem?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function()? refreshItems,
    TResult Function(SampleItem item)? createItem,
    TResult Function(SampleItem item)? updateItem,
    TResult Function(String id)? deleteItem,
    required TResult orElse(),
  }) {
    if (createItem != null) {
      return createItem(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_CreateItem value) createItem,
    required TResult Function(_UpdateItem value) updateItem,
    required TResult Function(_DeleteItem value) deleteItem,
  }) {
    return createItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_CreateItem value)? createItem,
    TResult? Function(_UpdateItem value)? updateItem,
    TResult? Function(_DeleteItem value)? deleteItem,
  }) {
    return createItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_CreateItem value)? createItem,
    TResult Function(_UpdateItem value)? updateItem,
    TResult Function(_DeleteItem value)? deleteItem,
    required TResult orElse(),
  }) {
    if (createItem != null) {
      return createItem(this);
    }
    return orElse();
  }
}

abstract class _CreateItem implements SampleEvent {
  const factory _CreateItem(final SampleItem item) = _$CreateItemImpl;

  SampleItem get item;

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateItemImplCopyWith<_$CreateItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateItemImplCopyWith<$Res> {
  factory _$$UpdateItemImplCopyWith(
    _$UpdateItemImpl value,
    $Res Function(_$UpdateItemImpl) then,
  ) = __$$UpdateItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SampleItem item});

  $SampleItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$UpdateItemImplCopyWithImpl<$Res>
    extends _$SampleEventCopyWithImpl<$Res, _$UpdateItemImpl>
    implements _$$UpdateItemImplCopyWith<$Res> {
  __$$UpdateItemImplCopyWithImpl(
    _$UpdateItemImpl _value,
    $Res Function(_$UpdateItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = null}) {
    return _then(
      _$UpdateItemImpl(
        null == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as SampleItem,
      ),
    );
  }

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SampleItemCopyWith<$Res> get item {
    return $SampleItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$UpdateItemImpl implements _UpdateItem {
  const _$UpdateItemImpl(this.item);

  @override
  final SampleItem item;

  @override
  String toString() {
    return 'SampleEvent.updateItem(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateItemImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateItemImplCopyWith<_$UpdateItemImpl> get copyWith =>
      __$$UpdateItemImplCopyWithImpl<_$UpdateItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function() refreshItems,
    required TResult Function(SampleItem item) createItem,
    required TResult Function(SampleItem item) updateItem,
    required TResult Function(String id) deleteItem,
  }) {
    return updateItem(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function()? refreshItems,
    TResult? Function(SampleItem item)? createItem,
    TResult? Function(SampleItem item)? updateItem,
    TResult? Function(String id)? deleteItem,
  }) {
    return updateItem?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function()? refreshItems,
    TResult Function(SampleItem item)? createItem,
    TResult Function(SampleItem item)? updateItem,
    TResult Function(String id)? deleteItem,
    required TResult orElse(),
  }) {
    if (updateItem != null) {
      return updateItem(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_CreateItem value) createItem,
    required TResult Function(_UpdateItem value) updateItem,
    required TResult Function(_DeleteItem value) deleteItem,
  }) {
    return updateItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_CreateItem value)? createItem,
    TResult? Function(_UpdateItem value)? updateItem,
    TResult? Function(_DeleteItem value)? deleteItem,
  }) {
    return updateItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_CreateItem value)? createItem,
    TResult Function(_UpdateItem value)? updateItem,
    TResult Function(_DeleteItem value)? deleteItem,
    required TResult orElse(),
  }) {
    if (updateItem != null) {
      return updateItem(this);
    }
    return orElse();
  }
}

abstract class _UpdateItem implements SampleEvent {
  const factory _UpdateItem(final SampleItem item) = _$UpdateItemImpl;

  SampleItem get item;

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateItemImplCopyWith<_$UpdateItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteItemImplCopyWith<$Res> {
  factory _$$DeleteItemImplCopyWith(
    _$DeleteItemImpl value,
    $Res Function(_$DeleteItemImpl) then,
  ) = __$$DeleteItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteItemImplCopyWithImpl<$Res>
    extends _$SampleEventCopyWithImpl<$Res, _$DeleteItemImpl>
    implements _$$DeleteItemImplCopyWith<$Res> {
  __$$DeleteItemImplCopyWithImpl(
    _$DeleteItemImpl _value,
    $Res Function(_$DeleteItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteItemImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteItemImpl implements _DeleteItem {
  const _$DeleteItemImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'SampleEvent.deleteItem(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteItemImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteItemImplCopyWith<_$DeleteItemImpl> get copyWith =>
      __$$DeleteItemImplCopyWithImpl<_$DeleteItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function() refreshItems,
    required TResult Function(SampleItem item) createItem,
    required TResult Function(SampleItem item) updateItem,
    required TResult Function(String id) deleteItem,
  }) {
    return deleteItem(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function()? refreshItems,
    TResult? Function(SampleItem item)? createItem,
    TResult? Function(SampleItem item)? updateItem,
    TResult? Function(String id)? deleteItem,
  }) {
    return deleteItem?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function()? refreshItems,
    TResult Function(SampleItem item)? createItem,
    TResult Function(SampleItem item)? updateItem,
    TResult Function(String id)? deleteItem,
    required TResult orElse(),
  }) {
    if (deleteItem != null) {
      return deleteItem(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_CreateItem value) createItem,
    required TResult Function(_UpdateItem value) updateItem,
    required TResult Function(_DeleteItem value) deleteItem,
  }) {
    return deleteItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_CreateItem value)? createItem,
    TResult? Function(_UpdateItem value)? updateItem,
    TResult? Function(_DeleteItem value)? deleteItem,
  }) {
    return deleteItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_CreateItem value)? createItem,
    TResult Function(_UpdateItem value)? updateItem,
    TResult Function(_DeleteItem value)? deleteItem,
    required TResult orElse(),
  }) {
    if (deleteItem != null) {
      return deleteItem(this);
    }
    return orElse();
  }
}

abstract class _DeleteItem implements SampleEvent {
  const factory _DeleteItem(final String id) = _$DeleteItemImpl;

  String get id;

  /// Create a copy of SampleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteItemImplCopyWith<_$DeleteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
