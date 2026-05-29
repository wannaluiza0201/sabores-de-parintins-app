// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment_mini.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstablishmentMini {

 int get id; String get slug; String get name;@JsonKey(name: 'cover_photo_url') String? get coverPhotoUrl;@JsonKey(name: 'primary_category') Category get primaryCategory;
/// Create a copy of EstablishmentMini
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentMiniCopyWith<EstablishmentMini> get copyWith => _$EstablishmentMiniCopyWithImpl<EstablishmentMini>(this as EstablishmentMini, _$identity);

  /// Serializes this EstablishmentMini to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstablishmentMini&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.primaryCategory, primaryCategory) || other.primaryCategory == primaryCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,name,coverPhotoUrl,primaryCategory);

@override
String toString() {
  return 'EstablishmentMini(id: $id, slug: $slug, name: $name, coverPhotoUrl: $coverPhotoUrl, primaryCategory: $primaryCategory)';
}


}

/// @nodoc
abstract mixin class $EstablishmentMiniCopyWith<$Res>  {
  factory $EstablishmentMiniCopyWith(EstablishmentMini value, $Res Function(EstablishmentMini) _then) = _$EstablishmentMiniCopyWithImpl;
@useResult
$Res call({
 int id, String slug, String name,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'primary_category') Category primaryCategory
});


$CategoryCopyWith<$Res> get primaryCategory;

}
/// @nodoc
class _$EstablishmentMiniCopyWithImpl<$Res>
    implements $EstablishmentMiniCopyWith<$Res> {
  _$EstablishmentMiniCopyWithImpl(this._self, this._then);

  final EstablishmentMini _self;
  final $Res Function(EstablishmentMini) _then;

/// Create a copy of EstablishmentMini
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? coverPhotoUrl = freezed,Object? primaryCategory = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryCategory: null == primaryCategory ? _self.primaryCategory : primaryCategory // ignore: cast_nullable_to_non_nullable
as Category,
  ));
}
/// Create a copy of EstablishmentMini
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get primaryCategory {
  
  return $CategoryCopyWith<$Res>(_self.primaryCategory, (value) {
    return _then(_self.copyWith(primaryCategory: value));
  });
}
}


/// Adds pattern-matching-related methods to [EstablishmentMini].
extension EstablishmentMiniPatterns on EstablishmentMini {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstablishmentMini value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstablishmentMini() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstablishmentMini value)  $default,){
final _that = this;
switch (_that) {
case _EstablishmentMini():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstablishmentMini value)?  $default,){
final _that = this;
switch (_that) {
case _EstablishmentMini() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String slug,  String name, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstablishmentMini() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.coverPhotoUrl,_that.primaryCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String slug,  String name, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory)  $default,) {final _that = this;
switch (_that) {
case _EstablishmentMini():
return $default(_that.id,_that.slug,_that.name,_that.coverPhotoUrl,_that.primaryCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String slug,  String name, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory)?  $default,) {final _that = this;
switch (_that) {
case _EstablishmentMini() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.coverPhotoUrl,_that.primaryCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstablishmentMini implements EstablishmentMini {
  const _EstablishmentMini({required this.id, required this.slug, required this.name, @JsonKey(name: 'cover_photo_url') this.coverPhotoUrl, @JsonKey(name: 'primary_category') required this.primaryCategory});
  factory _EstablishmentMini.fromJson(Map<String, dynamic> json) => _$EstablishmentMiniFromJson(json);

@override final  int id;
@override final  String slug;
@override final  String name;
@override@JsonKey(name: 'cover_photo_url') final  String? coverPhotoUrl;
@override@JsonKey(name: 'primary_category') final  Category primaryCategory;

/// Create a copy of EstablishmentMini
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentMiniCopyWith<_EstablishmentMini> get copyWith => __$EstablishmentMiniCopyWithImpl<_EstablishmentMini>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstablishmentMiniToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstablishmentMini&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.primaryCategory, primaryCategory) || other.primaryCategory == primaryCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,name,coverPhotoUrl,primaryCategory);

@override
String toString() {
  return 'EstablishmentMini(id: $id, slug: $slug, name: $name, coverPhotoUrl: $coverPhotoUrl, primaryCategory: $primaryCategory)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentMiniCopyWith<$Res> implements $EstablishmentMiniCopyWith<$Res> {
  factory _$EstablishmentMiniCopyWith(_EstablishmentMini value, $Res Function(_EstablishmentMini) _then) = __$EstablishmentMiniCopyWithImpl;
@override @useResult
$Res call({
 int id, String slug, String name,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'primary_category') Category primaryCategory
});


@override $CategoryCopyWith<$Res> get primaryCategory;

}
/// @nodoc
class __$EstablishmentMiniCopyWithImpl<$Res>
    implements _$EstablishmentMiniCopyWith<$Res> {
  __$EstablishmentMiniCopyWithImpl(this._self, this._then);

  final _EstablishmentMini _self;
  final $Res Function(_EstablishmentMini) _then;

/// Create a copy of EstablishmentMini
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? coverPhotoUrl = freezed,Object? primaryCategory = null,}) {
  return _then(_EstablishmentMini(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryCategory: null == primaryCategory ? _self.primaryCategory : primaryCategory // ignore: cast_nullable_to_non_nullable
as Category,
  ));
}

/// Create a copy of EstablishmentMini
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get primaryCategory {
  
  return $CategoryCopyWith<$Res>(_self.primaryCategory, (value) {
    return _then(_self.copyWith(primaryCategory: value));
  });
}
}

// dart format on
