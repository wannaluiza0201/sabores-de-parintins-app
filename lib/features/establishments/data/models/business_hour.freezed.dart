// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_hour.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessHour {

@JsonKey(name: 'day_of_week') int get dayOfWeek;@JsonKey(name: 'day_name') String get dayName;@JsonKey(name: 'opens_at') String? get opensAt;@JsonKey(name: 'closes_at') String? get closesAt;@JsonKey(name: 'is_closed') bool get isClosed;@JsonKey(name: 'crosses_midnight') bool get crossesMidnight;
/// Create a copy of BusinessHour
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessHourCopyWith<BusinessHour> get copyWith => _$BusinessHourCopyWithImpl<BusinessHour>(this as BusinessHour, _$identity);

  /// Serializes this BusinessHour to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessHour&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.dayName, dayName) || other.dayName == dayName)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.crossesMidnight, crossesMidnight) || other.crossesMidnight == crossesMidnight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,dayName,opensAt,closesAt,isClosed,crossesMidnight);

@override
String toString() {
  return 'BusinessHour(dayOfWeek: $dayOfWeek, dayName: $dayName, opensAt: $opensAt, closesAt: $closesAt, isClosed: $isClosed, crossesMidnight: $crossesMidnight)';
}


}

/// @nodoc
abstract mixin class $BusinessHourCopyWith<$Res>  {
  factory $BusinessHourCopyWith(BusinessHour value, $Res Function(BusinessHour) _then) = _$BusinessHourCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'day_of_week') int dayOfWeek,@JsonKey(name: 'day_name') String dayName,@JsonKey(name: 'opens_at') String? opensAt,@JsonKey(name: 'closes_at') String? closesAt,@JsonKey(name: 'is_closed') bool isClosed,@JsonKey(name: 'crosses_midnight') bool crossesMidnight
});




}
/// @nodoc
class _$BusinessHourCopyWithImpl<$Res>
    implements $BusinessHourCopyWith<$Res> {
  _$BusinessHourCopyWithImpl(this._self, this._then);

  final BusinessHour _self;
  final $Res Function(BusinessHour) _then;

/// Create a copy of BusinessHour
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayOfWeek = null,Object? dayName = null,Object? opensAt = freezed,Object? closesAt = freezed,Object? isClosed = null,Object? crossesMidnight = null,}) {
  return _then(_self.copyWith(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as String,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,crossesMidnight: null == crossesMidnight ? _self.crossesMidnight : crossesMidnight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessHour].
extension BusinessHourPatterns on BusinessHour {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessHour value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessHour() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessHour value)  $default,){
final _that = this;
switch (_that) {
case _BusinessHour():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessHour value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessHour() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'day_of_week')  int dayOfWeek, @JsonKey(name: 'day_name')  String dayName, @JsonKey(name: 'opens_at')  String? opensAt, @JsonKey(name: 'closes_at')  String? closesAt, @JsonKey(name: 'is_closed')  bool isClosed, @JsonKey(name: 'crosses_midnight')  bool crossesMidnight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessHour() when $default != null:
return $default(_that.dayOfWeek,_that.dayName,_that.opensAt,_that.closesAt,_that.isClosed,_that.crossesMidnight);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'day_of_week')  int dayOfWeek, @JsonKey(name: 'day_name')  String dayName, @JsonKey(name: 'opens_at')  String? opensAt, @JsonKey(name: 'closes_at')  String? closesAt, @JsonKey(name: 'is_closed')  bool isClosed, @JsonKey(name: 'crosses_midnight')  bool crossesMidnight)  $default,) {final _that = this;
switch (_that) {
case _BusinessHour():
return $default(_that.dayOfWeek,_that.dayName,_that.opensAt,_that.closesAt,_that.isClosed,_that.crossesMidnight);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'day_of_week')  int dayOfWeek, @JsonKey(name: 'day_name')  String dayName, @JsonKey(name: 'opens_at')  String? opensAt, @JsonKey(name: 'closes_at')  String? closesAt, @JsonKey(name: 'is_closed')  bool isClosed, @JsonKey(name: 'crosses_midnight')  bool crossesMidnight)?  $default,) {final _that = this;
switch (_that) {
case _BusinessHour() when $default != null:
return $default(_that.dayOfWeek,_that.dayName,_that.opensAt,_that.closesAt,_that.isClosed,_that.crossesMidnight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessHour implements BusinessHour {
  const _BusinessHour({@JsonKey(name: 'day_of_week') required this.dayOfWeek, @JsonKey(name: 'day_name') required this.dayName, @JsonKey(name: 'opens_at') this.opensAt, @JsonKey(name: 'closes_at') this.closesAt, @JsonKey(name: 'is_closed') required this.isClosed, @JsonKey(name: 'crosses_midnight') required this.crossesMidnight});
  factory _BusinessHour.fromJson(Map<String, dynamic> json) => _$BusinessHourFromJson(json);

@override@JsonKey(name: 'day_of_week') final  int dayOfWeek;
@override@JsonKey(name: 'day_name') final  String dayName;
@override@JsonKey(name: 'opens_at') final  String? opensAt;
@override@JsonKey(name: 'closes_at') final  String? closesAt;
@override@JsonKey(name: 'is_closed') final  bool isClosed;
@override@JsonKey(name: 'crosses_midnight') final  bool crossesMidnight;

/// Create a copy of BusinessHour
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessHourCopyWith<_BusinessHour> get copyWith => __$BusinessHourCopyWithImpl<_BusinessHour>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessHourToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessHour&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.dayName, dayName) || other.dayName == dayName)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.crossesMidnight, crossesMidnight) || other.crossesMidnight == crossesMidnight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,dayName,opensAt,closesAt,isClosed,crossesMidnight);

@override
String toString() {
  return 'BusinessHour(dayOfWeek: $dayOfWeek, dayName: $dayName, opensAt: $opensAt, closesAt: $closesAt, isClosed: $isClosed, crossesMidnight: $crossesMidnight)';
}


}

/// @nodoc
abstract mixin class _$BusinessHourCopyWith<$Res> implements $BusinessHourCopyWith<$Res> {
  factory _$BusinessHourCopyWith(_BusinessHour value, $Res Function(_BusinessHour) _then) = __$BusinessHourCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'day_of_week') int dayOfWeek,@JsonKey(name: 'day_name') String dayName,@JsonKey(name: 'opens_at') String? opensAt,@JsonKey(name: 'closes_at') String? closesAt,@JsonKey(name: 'is_closed') bool isClosed,@JsonKey(name: 'crosses_midnight') bool crossesMidnight
});




}
/// @nodoc
class __$BusinessHourCopyWithImpl<$Res>
    implements _$BusinessHourCopyWith<$Res> {
  __$BusinessHourCopyWithImpl(this._self, this._then);

  final _BusinessHour _self;
  final $Res Function(_BusinessHour) _then;

/// Create a copy of BusinessHour
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayOfWeek = null,Object? dayName = null,Object? opensAt = freezed,Object? closesAt = freezed,Object? isClosed = null,Object? crossesMidnight = null,}) {
  return _then(_BusinessHour(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as String,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,crossesMidnight: null == crossesMidnight ? _self.crossesMidnight : crossesMidnight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
