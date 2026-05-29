// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Feature {

 int get id; String get name; String get slug; String? get icon;
/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureCopyWith<Feature> get copyWith => _$FeatureCopyWithImpl<Feature>(this as Feature, _$identity);

  /// Serializes this Feature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Feature&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon);

@override
String toString() {
  return 'Feature(id: $id, name: $name, slug: $slug, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $FeatureCopyWith<$Res>  {
  factory $FeatureCopyWith(Feature value, $Res Function(Feature) _then) = _$FeatureCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? icon
});




}
/// @nodoc
class _$FeatureCopyWithImpl<$Res>
    implements $FeatureCopyWith<$Res> {
  _$FeatureCopyWithImpl(this._self, this._then);

  final Feature _self;
  final $Res Function(Feature) _then;

/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Feature].
extension FeaturePatterns on Feature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Feature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Feature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Feature value)  $default,){
final _that = this;
switch (_that) {
case _Feature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Feature value)?  $default,){
final _that = this;
switch (_that) {
case _Feature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Feature() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _Feature():
return $default(_that.id,_that.name,_that.slug,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _Feature() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Feature implements Feature {
  const _Feature({required this.id, required this.name, required this.slug, this.icon});
  factory _Feature.fromJson(Map<String, dynamic> json) => _$FeatureFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String? icon;

/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureCopyWith<_Feature> get copyWith => __$FeatureCopyWithImpl<_Feature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Feature&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon);

@override
String toString() {
  return 'Feature(id: $id, name: $name, slug: $slug, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$FeatureCopyWith<$Res> implements $FeatureCopyWith<$Res> {
  factory _$FeatureCopyWith(_Feature value, $Res Function(_Feature) _then) = __$FeatureCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? icon
});




}
/// @nodoc
class __$FeatureCopyWithImpl<$Res>
    implements _$FeatureCopyWith<$Res> {
  __$FeatureCopyWithImpl(this._self, this._then);

  final _Feature _self;
  final $Res Function(_Feature) _then;

/// Create a copy of Feature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,}) {
  return _then(_Feature(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
