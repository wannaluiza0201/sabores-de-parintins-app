// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Establishment {

 int get id; String get slug; String get name;// Nullable: o backend permite estabelecimento sem descrição.
 String? get description;@JsonKey(name: 'cover_photo_url') String? get coverPhotoUrl;@JsonKey(name: 'primary_category') Category get primaryCategory; List<Category> get categories; String get neighborhood; String get address;@JsonKey(name: 'is_open_now') bool get isOpenNow; double get latitude; double get longitude;@JsonKey(name: 'distance_km') double? get distanceKm;// Vem `true`/`false` quando há Bearer token; o campo é OMITIDO
// pra requests anônimas — por isso `bool?` (e não default `false`,
// pra distinguir "anônimo = desconhecido" de "logado = não favoritou").
@JsonKey(name: 'is_favorited') bool? get isFavorited;// Agregados de reviews — sempre presentes nos endpoints (defaults
// garantem comportamento estável mesmo se o backend mudar). Avgs
// viram null quando count == 0.
@JsonKey(name: 'reviews_count') int get reviewsCount;@JsonKey(name: 'reviews_avg_rating') double? get reviewsAvgRating;@JsonKey(name: 'reviews_avg_food') double? get reviewsAvgFood;@JsonKey(name: 'reviews_avg_service') double? get reviewsAvgService;@JsonKey(name: 'reviews_avg_ambience') double? get reviewsAvgAmbience;
/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentCopyWith<Establishment> get copyWith => _$EstablishmentCopyWithImpl<Establishment>(this as Establishment, _$identity);

  /// Serializes this Establishment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Establishment&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.primaryCategory, primaryCategory) || other.primaryCategory == primaryCategory)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.address, address) || other.address == address)&&(identical(other.isOpenNow, isOpenNow) || other.isOpenNow == isOpenNow)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.reviewsAvgRating, reviewsAvgRating) || other.reviewsAvgRating == reviewsAvgRating)&&(identical(other.reviewsAvgFood, reviewsAvgFood) || other.reviewsAvgFood == reviewsAvgFood)&&(identical(other.reviewsAvgService, reviewsAvgService) || other.reviewsAvgService == reviewsAvgService)&&(identical(other.reviewsAvgAmbience, reviewsAvgAmbience) || other.reviewsAvgAmbience == reviewsAvgAmbience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,slug,name,description,coverPhotoUrl,primaryCategory,const DeepCollectionEquality().hash(categories),neighborhood,address,isOpenNow,latitude,longitude,distanceKm,isFavorited,reviewsCount,reviewsAvgRating,reviewsAvgFood,reviewsAvgService,reviewsAvgAmbience]);

@override
String toString() {
  return 'Establishment(id: $id, slug: $slug, name: $name, description: $description, coverPhotoUrl: $coverPhotoUrl, primaryCategory: $primaryCategory, categories: $categories, neighborhood: $neighborhood, address: $address, isOpenNow: $isOpenNow, latitude: $latitude, longitude: $longitude, distanceKm: $distanceKm, isFavorited: $isFavorited, reviewsCount: $reviewsCount, reviewsAvgRating: $reviewsAvgRating, reviewsAvgFood: $reviewsAvgFood, reviewsAvgService: $reviewsAvgService, reviewsAvgAmbience: $reviewsAvgAmbience)';
}


}

/// @nodoc
abstract mixin class $EstablishmentCopyWith<$Res>  {
  factory $EstablishmentCopyWith(Establishment value, $Res Function(Establishment) _then) = _$EstablishmentCopyWithImpl;
@useResult
$Res call({
 int id, String slug, String name, String? description,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'primary_category') Category primaryCategory, List<Category> categories, String neighborhood, String address,@JsonKey(name: 'is_open_now') bool isOpenNow, double latitude, double longitude,@JsonKey(name: 'distance_km') double? distanceKm,@JsonKey(name: 'is_favorited') bool? isFavorited,@JsonKey(name: 'reviews_count') int reviewsCount,@JsonKey(name: 'reviews_avg_rating') double? reviewsAvgRating,@JsonKey(name: 'reviews_avg_food') double? reviewsAvgFood,@JsonKey(name: 'reviews_avg_service') double? reviewsAvgService,@JsonKey(name: 'reviews_avg_ambience') double? reviewsAvgAmbience
});


$CategoryCopyWith<$Res> get primaryCategory;

}
/// @nodoc
class _$EstablishmentCopyWithImpl<$Res>
    implements $EstablishmentCopyWith<$Res> {
  _$EstablishmentCopyWithImpl(this._self, this._then);

  final Establishment _self;
  final $Res Function(Establishment) _then;

/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? description = freezed,Object? coverPhotoUrl = freezed,Object? primaryCategory = null,Object? categories = null,Object? neighborhood = null,Object? address = null,Object? isOpenNow = null,Object? latitude = null,Object? longitude = null,Object? distanceKm = freezed,Object? isFavorited = freezed,Object? reviewsCount = null,Object? reviewsAvgRating = freezed,Object? reviewsAvgFood = freezed,Object? reviewsAvgService = freezed,Object? reviewsAvgAmbience = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryCategory: null == primaryCategory ? _self.primaryCategory : primaryCategory // ignore: cast_nullable_to_non_nullable
as Category,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,isOpenNow: null == isOpenNow ? _self.isOpenNow : isOpenNow // ignore: cast_nullable_to_non_nullable
as bool,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,isFavorited: freezed == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool?,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,reviewsAvgRating: freezed == reviewsAvgRating ? _self.reviewsAvgRating : reviewsAvgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgFood: freezed == reviewsAvgFood ? _self.reviewsAvgFood : reviewsAvgFood // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgService: freezed == reviewsAvgService ? _self.reviewsAvgService : reviewsAvgService // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgAmbience: freezed == reviewsAvgAmbience ? _self.reviewsAvgAmbience : reviewsAvgAmbience // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get primaryCategory {
  
  return $CategoryCopyWith<$Res>(_self.primaryCategory, (value) {
    return _then(_self.copyWith(primaryCategory: value));
  });
}
}


/// Adds pattern-matching-related methods to [Establishment].
extension EstablishmentPatterns on Establishment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Establishment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Establishment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Establishment value)  $default,){
final _that = this;
switch (_that) {
case _Establishment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Establishment value)?  $default,){
final _that = this;
switch (_that) {
case _Establishment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String slug,  String name,  String? description, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory,  List<Category> categories,  String neighborhood,  String address, @JsonKey(name: 'is_open_now')  bool isOpenNow,  double latitude,  double longitude, @JsonKey(name: 'distance_km')  double? distanceKm, @JsonKey(name: 'is_favorited')  bool? isFavorited, @JsonKey(name: 'reviews_count')  int reviewsCount, @JsonKey(name: 'reviews_avg_rating')  double? reviewsAvgRating, @JsonKey(name: 'reviews_avg_food')  double? reviewsAvgFood, @JsonKey(name: 'reviews_avg_service')  double? reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience')  double? reviewsAvgAmbience)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Establishment() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.description,_that.coverPhotoUrl,_that.primaryCategory,_that.categories,_that.neighborhood,_that.address,_that.isOpenNow,_that.latitude,_that.longitude,_that.distanceKm,_that.isFavorited,_that.reviewsCount,_that.reviewsAvgRating,_that.reviewsAvgFood,_that.reviewsAvgService,_that.reviewsAvgAmbience);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String slug,  String name,  String? description, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory,  List<Category> categories,  String neighborhood,  String address, @JsonKey(name: 'is_open_now')  bool isOpenNow,  double latitude,  double longitude, @JsonKey(name: 'distance_km')  double? distanceKm, @JsonKey(name: 'is_favorited')  bool? isFavorited, @JsonKey(name: 'reviews_count')  int reviewsCount, @JsonKey(name: 'reviews_avg_rating')  double? reviewsAvgRating, @JsonKey(name: 'reviews_avg_food')  double? reviewsAvgFood, @JsonKey(name: 'reviews_avg_service')  double? reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience')  double? reviewsAvgAmbience)  $default,) {final _that = this;
switch (_that) {
case _Establishment():
return $default(_that.id,_that.slug,_that.name,_that.description,_that.coverPhotoUrl,_that.primaryCategory,_that.categories,_that.neighborhood,_that.address,_that.isOpenNow,_that.latitude,_that.longitude,_that.distanceKm,_that.isFavorited,_that.reviewsCount,_that.reviewsAvgRating,_that.reviewsAvgFood,_that.reviewsAvgService,_that.reviewsAvgAmbience);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String slug,  String name,  String? description, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory,  List<Category> categories,  String neighborhood,  String address, @JsonKey(name: 'is_open_now')  bool isOpenNow,  double latitude,  double longitude, @JsonKey(name: 'distance_km')  double? distanceKm, @JsonKey(name: 'is_favorited')  bool? isFavorited, @JsonKey(name: 'reviews_count')  int reviewsCount, @JsonKey(name: 'reviews_avg_rating')  double? reviewsAvgRating, @JsonKey(name: 'reviews_avg_food')  double? reviewsAvgFood, @JsonKey(name: 'reviews_avg_service')  double? reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience')  double? reviewsAvgAmbience)?  $default,) {final _that = this;
switch (_that) {
case _Establishment() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.description,_that.coverPhotoUrl,_that.primaryCategory,_that.categories,_that.neighborhood,_that.address,_that.isOpenNow,_that.latitude,_that.longitude,_that.distanceKm,_that.isFavorited,_that.reviewsCount,_that.reviewsAvgRating,_that.reviewsAvgFood,_that.reviewsAvgService,_that.reviewsAvgAmbience);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Establishment implements Establishment {
  const _Establishment({required this.id, required this.slug, required this.name, this.description, @JsonKey(name: 'cover_photo_url') this.coverPhotoUrl, @JsonKey(name: 'primary_category') required this.primaryCategory, required final  List<Category> categories, required this.neighborhood, required this.address, @JsonKey(name: 'is_open_now') required this.isOpenNow, required this.latitude, required this.longitude, @JsonKey(name: 'distance_km') this.distanceKm, @JsonKey(name: 'is_favorited') this.isFavorited, @JsonKey(name: 'reviews_count') this.reviewsCount = 0, @JsonKey(name: 'reviews_avg_rating') this.reviewsAvgRating, @JsonKey(name: 'reviews_avg_food') this.reviewsAvgFood, @JsonKey(name: 'reviews_avg_service') this.reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience') this.reviewsAvgAmbience}): _categories = categories;
  factory _Establishment.fromJson(Map<String, dynamic> json) => _$EstablishmentFromJson(json);

@override final  int id;
@override final  String slug;
@override final  String name;
// Nullable: o backend permite estabelecimento sem descrição.
@override final  String? description;
@override@JsonKey(name: 'cover_photo_url') final  String? coverPhotoUrl;
@override@JsonKey(name: 'primary_category') final  Category primaryCategory;
 final  List<Category> _categories;
@override List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String neighborhood;
@override final  String address;
@override@JsonKey(name: 'is_open_now') final  bool isOpenNow;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey(name: 'distance_km') final  double? distanceKm;
// Vem `true`/`false` quando há Bearer token; o campo é OMITIDO
// pra requests anônimas — por isso `bool?` (e não default `false`,
// pra distinguir "anônimo = desconhecido" de "logado = não favoritou").
@override@JsonKey(name: 'is_favorited') final  bool? isFavorited;
// Agregados de reviews — sempre presentes nos endpoints (defaults
// garantem comportamento estável mesmo se o backend mudar). Avgs
// viram null quando count == 0.
@override@JsonKey(name: 'reviews_count') final  int reviewsCount;
@override@JsonKey(name: 'reviews_avg_rating') final  double? reviewsAvgRating;
@override@JsonKey(name: 'reviews_avg_food') final  double? reviewsAvgFood;
@override@JsonKey(name: 'reviews_avg_service') final  double? reviewsAvgService;
@override@JsonKey(name: 'reviews_avg_ambience') final  double? reviewsAvgAmbience;

/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentCopyWith<_Establishment> get copyWith => __$EstablishmentCopyWithImpl<_Establishment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstablishmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Establishment&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.primaryCategory, primaryCategory) || other.primaryCategory == primaryCategory)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.address, address) || other.address == address)&&(identical(other.isOpenNow, isOpenNow) || other.isOpenNow == isOpenNow)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.reviewsAvgRating, reviewsAvgRating) || other.reviewsAvgRating == reviewsAvgRating)&&(identical(other.reviewsAvgFood, reviewsAvgFood) || other.reviewsAvgFood == reviewsAvgFood)&&(identical(other.reviewsAvgService, reviewsAvgService) || other.reviewsAvgService == reviewsAvgService)&&(identical(other.reviewsAvgAmbience, reviewsAvgAmbience) || other.reviewsAvgAmbience == reviewsAvgAmbience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,slug,name,description,coverPhotoUrl,primaryCategory,const DeepCollectionEquality().hash(_categories),neighborhood,address,isOpenNow,latitude,longitude,distanceKm,isFavorited,reviewsCount,reviewsAvgRating,reviewsAvgFood,reviewsAvgService,reviewsAvgAmbience]);

@override
String toString() {
  return 'Establishment(id: $id, slug: $slug, name: $name, description: $description, coverPhotoUrl: $coverPhotoUrl, primaryCategory: $primaryCategory, categories: $categories, neighborhood: $neighborhood, address: $address, isOpenNow: $isOpenNow, latitude: $latitude, longitude: $longitude, distanceKm: $distanceKm, isFavorited: $isFavorited, reviewsCount: $reviewsCount, reviewsAvgRating: $reviewsAvgRating, reviewsAvgFood: $reviewsAvgFood, reviewsAvgService: $reviewsAvgService, reviewsAvgAmbience: $reviewsAvgAmbience)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentCopyWith<$Res> implements $EstablishmentCopyWith<$Res> {
  factory _$EstablishmentCopyWith(_Establishment value, $Res Function(_Establishment) _then) = __$EstablishmentCopyWithImpl;
@override @useResult
$Res call({
 int id, String slug, String name, String? description,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'primary_category') Category primaryCategory, List<Category> categories, String neighborhood, String address,@JsonKey(name: 'is_open_now') bool isOpenNow, double latitude, double longitude,@JsonKey(name: 'distance_km') double? distanceKm,@JsonKey(name: 'is_favorited') bool? isFavorited,@JsonKey(name: 'reviews_count') int reviewsCount,@JsonKey(name: 'reviews_avg_rating') double? reviewsAvgRating,@JsonKey(name: 'reviews_avg_food') double? reviewsAvgFood,@JsonKey(name: 'reviews_avg_service') double? reviewsAvgService,@JsonKey(name: 'reviews_avg_ambience') double? reviewsAvgAmbience
});


@override $CategoryCopyWith<$Res> get primaryCategory;

}
/// @nodoc
class __$EstablishmentCopyWithImpl<$Res>
    implements _$EstablishmentCopyWith<$Res> {
  __$EstablishmentCopyWithImpl(this._self, this._then);

  final _Establishment _self;
  final $Res Function(_Establishment) _then;

/// Create a copy of Establishment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? description = freezed,Object? coverPhotoUrl = freezed,Object? primaryCategory = null,Object? categories = null,Object? neighborhood = null,Object? address = null,Object? isOpenNow = null,Object? latitude = null,Object? longitude = null,Object? distanceKm = freezed,Object? isFavorited = freezed,Object? reviewsCount = null,Object? reviewsAvgRating = freezed,Object? reviewsAvgFood = freezed,Object? reviewsAvgService = freezed,Object? reviewsAvgAmbience = freezed,}) {
  return _then(_Establishment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryCategory: null == primaryCategory ? _self.primaryCategory : primaryCategory // ignore: cast_nullable_to_non_nullable
as Category,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,isOpenNow: null == isOpenNow ? _self.isOpenNow : isOpenNow // ignore: cast_nullable_to_non_nullable
as bool,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,isFavorited: freezed == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool?,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,reviewsAvgRating: freezed == reviewsAvgRating ? _self.reviewsAvgRating : reviewsAvgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgFood: freezed == reviewsAvgFood ? _self.reviewsAvgFood : reviewsAvgFood // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgService: freezed == reviewsAvgService ? _self.reviewsAvgService : reviewsAvgService // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgAmbience: freezed == reviewsAvgAmbience ? _self.reviewsAvgAmbience : reviewsAvgAmbience // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of Establishment
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
