// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SampleItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Create a copy of SampleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SampleItemCopyWith<SampleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleItemCopyWith<$Res> {
  factory $SampleItemCopyWith(
    SampleItem value,
    $Res Function(SampleItem) then,
  ) = _$SampleItemCopyWithImpl<$Res, SampleItem>;
  @useResult
  $Res call({String id, String title, String description, bool isCompleted});
}

/// @nodoc
class _$SampleItemCopyWithImpl<$Res, $Val extends SampleItem>
    implements $SampleItemCopyWith<$Res> {
  _$SampleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SampleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SampleItemImplCopyWith<$Res>
    implements $SampleItemCopyWith<$Res> {
  factory _$$SampleItemImplCopyWith(
    _$SampleItemImpl value,
    $Res Function(_$SampleItemImpl) then,
  ) = __$$SampleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String description, bool isCompleted});
}

/// @nodoc
class __$$SampleItemImplCopyWithImpl<$Res>
    extends _$SampleItemCopyWithImpl<$Res, _$SampleItemImpl>
    implements _$$SampleItemImplCopyWith<$Res> {
  __$$SampleItemImplCopyWithImpl(
    _$SampleItemImpl _value,
    $Res Function(_$SampleItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SampleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
  }) {
    return _then(
      _$SampleItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SampleItemImpl implements _SampleItem {
  const _$SampleItemImpl({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'SampleItem(id: $id, title: $title, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, isCompleted);

  /// Create a copy of SampleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleItemImplCopyWith<_$SampleItemImpl> get copyWith =>
      __$$SampleItemImplCopyWithImpl<_$SampleItemImpl>(this, _$identity);
}

abstract class _SampleItem implements SampleItem {
  const factory _SampleItem({
    required final String id,
    required final String title,
    required final String description,
    final bool isCompleted,
  }) = _$SampleItemImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  bool get isCompleted;

  /// Create a copy of SampleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SampleItemImplCopyWith<_$SampleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
