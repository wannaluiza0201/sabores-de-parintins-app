// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'establishment_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstablishmentDetail {

 int get id; String get slug; String get name; String? get description; String? get phone; String? get whatsapp;@JsonKey(name: 'whatsapp_url') String? get whatsappUrl; String? get instagram;@JsonKey(name: 'instagram_url') String? get instagramUrl; String get address; String get neighborhood; double get latitude; double get longitude;@JsonKey(name: 'cover_photo_url') String? get coverPhotoUrl;@JsonKey(name: 'primary_category') Category get primaryCategory; List<Category> get categories; List<Feature> get features;@JsonKey(name: 'business_hours') List<BusinessHour> get businessHours;@JsonKey(name: 'is_open_now') bool get isOpenNow;@JsonKey(name: 'current_status_message') String get currentStatusMessage;@JsonKey(name: 'photos_count') int get photosCount;// Agregados de reviews — sempre presentes (defaults se backend mudar).
@JsonKey(name: 'reviews_count') int get reviewsCount;@JsonKey(name: 'reviews_avg_rating') double? get reviewsAvgRating;@JsonKey(name: 'reviews_avg_food') double? get reviewsAvgFood;@JsonKey(name: 'reviews_avg_service') double? get reviewsAvgService;@JsonKey(name: 'reviews_avg_ambience') double? get reviewsAvgAmbience;// Review do usuário atual (qualquer status). null se não avaliou
// OU se a request foi anônima (campo omitido).
@JsonKey(name: 'user_review') Review? get userReview;
/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstablishmentDetailCopyWith<EstablishmentDetail> get copyWith => _$EstablishmentDetailCopyWithImpl<EstablishmentDetail>(this as EstablishmentDetail, _$identity);

  /// Serializes this EstablishmentDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstablishmentDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.whatsappUrl, whatsappUrl) || other.whatsappUrl == whatsappUrl)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.instagramUrl, instagramUrl) || other.instagramUrl == instagramUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.primaryCategory, primaryCategory) || other.primaryCategory == primaryCategory)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.businessHours, businessHours)&&(identical(other.isOpenNow, isOpenNow) || other.isOpenNow == isOpenNow)&&(identical(other.currentStatusMessage, currentStatusMessage) || other.currentStatusMessage == currentStatusMessage)&&(identical(other.photosCount, photosCount) || other.photosCount == photosCount)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.reviewsAvgRating, reviewsAvgRating) || other.reviewsAvgRating == reviewsAvgRating)&&(identical(other.reviewsAvgFood, reviewsAvgFood) || other.reviewsAvgFood == reviewsAvgFood)&&(identical(other.reviewsAvgService, reviewsAvgService) || other.reviewsAvgService == reviewsAvgService)&&(identical(other.reviewsAvgAmbience, reviewsAvgAmbience) || other.reviewsAvgAmbience == reviewsAvgAmbience)&&(identical(other.userReview, userReview) || other.userReview == userReview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,slug,name,description,phone,whatsapp,whatsappUrl,instagram,instagramUrl,address,neighborhood,latitude,longitude,coverPhotoUrl,primaryCategory,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(businessHours),isOpenNow,currentStatusMessage,photosCount,reviewsCount,reviewsAvgRating,reviewsAvgFood,reviewsAvgService,reviewsAvgAmbience,userReview]);

@override
String toString() {
  return 'EstablishmentDetail(id: $id, slug: $slug, name: $name, description: $description, phone: $phone, whatsapp: $whatsapp, whatsappUrl: $whatsappUrl, instagram: $instagram, instagramUrl: $instagramUrl, address: $address, neighborhood: $neighborhood, latitude: $latitude, longitude: $longitude, coverPhotoUrl: $coverPhotoUrl, primaryCategory: $primaryCategory, categories: $categories, features: $features, businessHours: $businessHours, isOpenNow: $isOpenNow, currentStatusMessage: $currentStatusMessage, photosCount: $photosCount, reviewsCount: $reviewsCount, reviewsAvgRating: $reviewsAvgRating, reviewsAvgFood: $reviewsAvgFood, reviewsAvgService: $reviewsAvgService, reviewsAvgAmbience: $reviewsAvgAmbience, userReview: $userReview)';
}


}

/// @nodoc
abstract mixin class $EstablishmentDetailCopyWith<$Res>  {
  factory $EstablishmentDetailCopyWith(EstablishmentDetail value, $Res Function(EstablishmentDetail) _then) = _$EstablishmentDetailCopyWithImpl;
@useResult
$Res call({
 int id, String slug, String name, String? description, String? phone, String? whatsapp,@JsonKey(name: 'whatsapp_url') String? whatsappUrl, String? instagram,@JsonKey(name: 'instagram_url') String? instagramUrl, String address, String neighborhood, double latitude, double longitude,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'primary_category') Category primaryCategory, List<Category> categories, List<Feature> features,@JsonKey(name: 'business_hours') List<BusinessHour> businessHours,@JsonKey(name: 'is_open_now') bool isOpenNow,@JsonKey(name: 'current_status_message') String currentStatusMessage,@JsonKey(name: 'photos_count') int photosCount,@JsonKey(name: 'reviews_count') int reviewsCount,@JsonKey(name: 'reviews_avg_rating') double? reviewsAvgRating,@JsonKey(name: 'reviews_avg_food') double? reviewsAvgFood,@JsonKey(name: 'reviews_avg_service') double? reviewsAvgService,@JsonKey(name: 'reviews_avg_ambience') double? reviewsAvgAmbience,@JsonKey(name: 'user_review') Review? userReview
});


$CategoryCopyWith<$Res> get primaryCategory;$ReviewCopyWith<$Res>? get userReview;

}
/// @nodoc
class _$EstablishmentDetailCopyWithImpl<$Res>
    implements $EstablishmentDetailCopyWith<$Res> {
  _$EstablishmentDetailCopyWithImpl(this._self, this._then);

  final EstablishmentDetail _self;
  final $Res Function(EstablishmentDetail) _then;

/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? description = freezed,Object? phone = freezed,Object? whatsapp = freezed,Object? whatsappUrl = freezed,Object? instagram = freezed,Object? instagramUrl = freezed,Object? address = null,Object? neighborhood = null,Object? latitude = null,Object? longitude = null,Object? coverPhotoUrl = freezed,Object? primaryCategory = null,Object? categories = null,Object? features = null,Object? businessHours = null,Object? isOpenNow = null,Object? currentStatusMessage = null,Object? photosCount = null,Object? reviewsCount = null,Object? reviewsAvgRating = freezed,Object? reviewsAvgFood = freezed,Object? reviewsAvgService = freezed,Object? reviewsAvgAmbience = freezed,Object? userReview = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,whatsapp: freezed == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String?,whatsappUrl: freezed == whatsappUrl ? _self.whatsappUrl : whatsappUrl // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,instagramUrl: freezed == instagramUrl ? _self.instagramUrl : instagramUrl // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryCategory: null == primaryCategory ? _self.primaryCategory : primaryCategory // ignore: cast_nullable_to_non_nullable
as Category,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<Feature>,businessHours: null == businessHours ? _self.businessHours : businessHours // ignore: cast_nullable_to_non_nullable
as List<BusinessHour>,isOpenNow: null == isOpenNow ? _self.isOpenNow : isOpenNow // ignore: cast_nullable_to_non_nullable
as bool,currentStatusMessage: null == currentStatusMessage ? _self.currentStatusMessage : currentStatusMessage // ignore: cast_nullable_to_non_nullable
as String,photosCount: null == photosCount ? _self.photosCount : photosCount // ignore: cast_nullable_to_non_nullable
as int,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,reviewsAvgRating: freezed == reviewsAvgRating ? _self.reviewsAvgRating : reviewsAvgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgFood: freezed == reviewsAvgFood ? _self.reviewsAvgFood : reviewsAvgFood // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgService: freezed == reviewsAvgService ? _self.reviewsAvgService : reviewsAvgService // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgAmbience: freezed == reviewsAvgAmbience ? _self.reviewsAvgAmbience : reviewsAvgAmbience // ignore: cast_nullable_to_non_nullable
as double?,userReview: freezed == userReview ? _self.userReview : userReview // ignore: cast_nullable_to_non_nullable
as Review?,
  ));
}
/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get primaryCategory {
  
  return $CategoryCopyWith<$Res>(_self.primaryCategory, (value) {
    return _then(_self.copyWith(primaryCategory: value));
  });
}/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewCopyWith<$Res>? get userReview {
    if (_self.userReview == null) {
    return null;
  }

  return $ReviewCopyWith<$Res>(_self.userReview!, (value) {
    return _then(_self.copyWith(userReview: value));
  });
}
}


/// Adds pattern-matching-related methods to [EstablishmentDetail].
extension EstablishmentDetailPatterns on EstablishmentDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstablishmentDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstablishmentDetail value)  $default,){
final _that = this;
switch (_that) {
case _EstablishmentDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstablishmentDetail value)?  $default,){
final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String slug,  String name,  String? description,  String? phone,  String? whatsapp, @JsonKey(name: 'whatsapp_url')  String? whatsappUrl,  String? instagram, @JsonKey(name: 'instagram_url')  String? instagramUrl,  String address,  String neighborhood,  double latitude,  double longitude, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory,  List<Category> categories,  List<Feature> features, @JsonKey(name: 'business_hours')  List<BusinessHour> businessHours, @JsonKey(name: 'is_open_now')  bool isOpenNow, @JsonKey(name: 'current_status_message')  String currentStatusMessage, @JsonKey(name: 'photos_count')  int photosCount, @JsonKey(name: 'reviews_count')  int reviewsCount, @JsonKey(name: 'reviews_avg_rating')  double? reviewsAvgRating, @JsonKey(name: 'reviews_avg_food')  double? reviewsAvgFood, @JsonKey(name: 'reviews_avg_service')  double? reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience')  double? reviewsAvgAmbience, @JsonKey(name: 'user_review')  Review? userReview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.description,_that.phone,_that.whatsapp,_that.whatsappUrl,_that.instagram,_that.instagramUrl,_that.address,_that.neighborhood,_that.latitude,_that.longitude,_that.coverPhotoUrl,_that.primaryCategory,_that.categories,_that.features,_that.businessHours,_that.isOpenNow,_that.currentStatusMessage,_that.photosCount,_that.reviewsCount,_that.reviewsAvgRating,_that.reviewsAvgFood,_that.reviewsAvgService,_that.reviewsAvgAmbience,_that.userReview);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String slug,  String name,  String? description,  String? phone,  String? whatsapp, @JsonKey(name: 'whatsapp_url')  String? whatsappUrl,  String? instagram, @JsonKey(name: 'instagram_url')  String? instagramUrl,  String address,  String neighborhood,  double latitude,  double longitude, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory,  List<Category> categories,  List<Feature> features, @JsonKey(name: 'business_hours')  List<BusinessHour> businessHours, @JsonKey(name: 'is_open_now')  bool isOpenNow, @JsonKey(name: 'current_status_message')  String currentStatusMessage, @JsonKey(name: 'photos_count')  int photosCount, @JsonKey(name: 'reviews_count')  int reviewsCount, @JsonKey(name: 'reviews_avg_rating')  double? reviewsAvgRating, @JsonKey(name: 'reviews_avg_food')  double? reviewsAvgFood, @JsonKey(name: 'reviews_avg_service')  double? reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience')  double? reviewsAvgAmbience, @JsonKey(name: 'user_review')  Review? userReview)  $default,) {final _that = this;
switch (_that) {
case _EstablishmentDetail():
return $default(_that.id,_that.slug,_that.name,_that.description,_that.phone,_that.whatsapp,_that.whatsappUrl,_that.instagram,_that.instagramUrl,_that.address,_that.neighborhood,_that.latitude,_that.longitude,_that.coverPhotoUrl,_that.primaryCategory,_that.categories,_that.features,_that.businessHours,_that.isOpenNow,_that.currentStatusMessage,_that.photosCount,_that.reviewsCount,_that.reviewsAvgRating,_that.reviewsAvgFood,_that.reviewsAvgService,_that.reviewsAvgAmbience,_that.userReview);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String slug,  String name,  String? description,  String? phone,  String? whatsapp, @JsonKey(name: 'whatsapp_url')  String? whatsappUrl,  String? instagram, @JsonKey(name: 'instagram_url')  String? instagramUrl,  String address,  String neighborhood,  double latitude,  double longitude, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'primary_category')  Category primaryCategory,  List<Category> categories,  List<Feature> features, @JsonKey(name: 'business_hours')  List<BusinessHour> businessHours, @JsonKey(name: 'is_open_now')  bool isOpenNow, @JsonKey(name: 'current_status_message')  String currentStatusMessage, @JsonKey(name: 'photos_count')  int photosCount, @JsonKey(name: 'reviews_count')  int reviewsCount, @JsonKey(name: 'reviews_avg_rating')  double? reviewsAvgRating, @JsonKey(name: 'reviews_avg_food')  double? reviewsAvgFood, @JsonKey(name: 'reviews_avg_service')  double? reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience')  double? reviewsAvgAmbience, @JsonKey(name: 'user_review')  Review? userReview)?  $default,) {final _that = this;
switch (_that) {
case _EstablishmentDetail() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.description,_that.phone,_that.whatsapp,_that.whatsappUrl,_that.instagram,_that.instagramUrl,_that.address,_that.neighborhood,_that.latitude,_that.longitude,_that.coverPhotoUrl,_that.primaryCategory,_that.categories,_that.features,_that.businessHours,_that.isOpenNow,_that.currentStatusMessage,_that.photosCount,_that.reviewsCount,_that.reviewsAvgRating,_that.reviewsAvgFood,_that.reviewsAvgService,_that.reviewsAvgAmbience,_that.userReview);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstablishmentDetail implements EstablishmentDetail {
  const _EstablishmentDetail({required this.id, required this.slug, required this.name, this.description, this.phone, this.whatsapp, @JsonKey(name: 'whatsapp_url') this.whatsappUrl, this.instagram, @JsonKey(name: 'instagram_url') this.instagramUrl, required this.address, required this.neighborhood, required this.latitude, required this.longitude, @JsonKey(name: 'cover_photo_url') this.coverPhotoUrl, @JsonKey(name: 'primary_category') required this.primaryCategory, required final  List<Category> categories, required final  List<Feature> features, @JsonKey(name: 'business_hours') required final  List<BusinessHour> businessHours, @JsonKey(name: 'is_open_now') required this.isOpenNow, @JsonKey(name: 'current_status_message') required this.currentStatusMessage, @JsonKey(name: 'photos_count') required this.photosCount, @JsonKey(name: 'reviews_count') this.reviewsCount = 0, @JsonKey(name: 'reviews_avg_rating') this.reviewsAvgRating, @JsonKey(name: 'reviews_avg_food') this.reviewsAvgFood, @JsonKey(name: 'reviews_avg_service') this.reviewsAvgService, @JsonKey(name: 'reviews_avg_ambience') this.reviewsAvgAmbience, @JsonKey(name: 'user_review') this.userReview}): _categories = categories,_features = features,_businessHours = businessHours;
  factory _EstablishmentDetail.fromJson(Map<String, dynamic> json) => _$EstablishmentDetailFromJson(json);

@override final  int id;
@override final  String slug;
@override final  String name;
@override final  String? description;
@override final  String? phone;
@override final  String? whatsapp;
@override@JsonKey(name: 'whatsapp_url') final  String? whatsappUrl;
@override final  String? instagram;
@override@JsonKey(name: 'instagram_url') final  String? instagramUrl;
@override final  String address;
@override final  String neighborhood;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey(name: 'cover_photo_url') final  String? coverPhotoUrl;
@override@JsonKey(name: 'primary_category') final  Category primaryCategory;
 final  List<Category> _categories;
@override List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Feature> _features;
@override List<Feature> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

 final  List<BusinessHour> _businessHours;
@override@JsonKey(name: 'business_hours') List<BusinessHour> get businessHours {
  if (_businessHours is EqualUnmodifiableListView) return _businessHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_businessHours);
}

@override@JsonKey(name: 'is_open_now') final  bool isOpenNow;
@override@JsonKey(name: 'current_status_message') final  String currentStatusMessage;
@override@JsonKey(name: 'photos_count') final  int photosCount;
// Agregados de reviews — sempre presentes (defaults se backend mudar).
@override@JsonKey(name: 'reviews_count') final  int reviewsCount;
@override@JsonKey(name: 'reviews_avg_rating') final  double? reviewsAvgRating;
@override@JsonKey(name: 'reviews_avg_food') final  double? reviewsAvgFood;
@override@JsonKey(name: 'reviews_avg_service') final  double? reviewsAvgService;
@override@JsonKey(name: 'reviews_avg_ambience') final  double? reviewsAvgAmbience;
// Review do usuário atual (qualquer status). null se não avaliou
// OU se a request foi anônima (campo omitido).
@override@JsonKey(name: 'user_review') final  Review? userReview;

/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstablishmentDetailCopyWith<_EstablishmentDetail> get copyWith => __$EstablishmentDetailCopyWithImpl<_EstablishmentDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstablishmentDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstablishmentDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.whatsappUrl, whatsappUrl) || other.whatsappUrl == whatsappUrl)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.instagramUrl, instagramUrl) || other.instagramUrl == instagramUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.primaryCategory, primaryCategory) || other.primaryCategory == primaryCategory)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._businessHours, _businessHours)&&(identical(other.isOpenNow, isOpenNow) || other.isOpenNow == isOpenNow)&&(identical(other.currentStatusMessage, currentStatusMessage) || other.currentStatusMessage == currentStatusMessage)&&(identical(other.photosCount, photosCount) || other.photosCount == photosCount)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.reviewsAvgRating, reviewsAvgRating) || other.reviewsAvgRating == reviewsAvgRating)&&(identical(other.reviewsAvgFood, reviewsAvgFood) || other.reviewsAvgFood == reviewsAvgFood)&&(identical(other.reviewsAvgService, reviewsAvgService) || other.reviewsAvgService == reviewsAvgService)&&(identical(other.reviewsAvgAmbience, reviewsAvgAmbience) || other.reviewsAvgAmbience == reviewsAvgAmbience)&&(identical(other.userReview, userReview) || other.userReview == userReview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,slug,name,description,phone,whatsapp,whatsappUrl,instagram,instagramUrl,address,neighborhood,latitude,longitude,coverPhotoUrl,primaryCategory,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_businessHours),isOpenNow,currentStatusMessage,photosCount,reviewsCount,reviewsAvgRating,reviewsAvgFood,reviewsAvgService,reviewsAvgAmbience,userReview]);

@override
String toString() {
  return 'EstablishmentDetail(id: $id, slug: $slug, name: $name, description: $description, phone: $phone, whatsapp: $whatsapp, whatsappUrl: $whatsappUrl, instagram: $instagram, instagramUrl: $instagramUrl, address: $address, neighborhood: $neighborhood, latitude: $latitude, longitude: $longitude, coverPhotoUrl: $coverPhotoUrl, primaryCategory: $primaryCategory, categories: $categories, features: $features, businessHours: $businessHours, isOpenNow: $isOpenNow, currentStatusMessage: $currentStatusMessage, photosCount: $photosCount, reviewsCount: $reviewsCount, reviewsAvgRating: $reviewsAvgRating, reviewsAvgFood: $reviewsAvgFood, reviewsAvgService: $reviewsAvgService, reviewsAvgAmbience: $reviewsAvgAmbience, userReview: $userReview)';
}


}

/// @nodoc
abstract mixin class _$EstablishmentDetailCopyWith<$Res> implements $EstablishmentDetailCopyWith<$Res> {
  factory _$EstablishmentDetailCopyWith(_EstablishmentDetail value, $Res Function(_EstablishmentDetail) _then) = __$EstablishmentDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String slug, String name, String? description, String? phone, String? whatsapp,@JsonKey(name: 'whatsapp_url') String? whatsappUrl, String? instagram,@JsonKey(name: 'instagram_url') String? instagramUrl, String address, String neighborhood, double latitude, double longitude,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'primary_category') Category primaryCategory, List<Category> categories, List<Feature> features,@JsonKey(name: 'business_hours') List<BusinessHour> businessHours,@JsonKey(name: 'is_open_now') bool isOpenNow,@JsonKey(name: 'current_status_message') String currentStatusMessage,@JsonKey(name: 'photos_count') int photosCount,@JsonKey(name: 'reviews_count') int reviewsCount,@JsonKey(name: 'reviews_avg_rating') double? reviewsAvgRating,@JsonKey(name: 'reviews_avg_food') double? reviewsAvgFood,@JsonKey(name: 'reviews_avg_service') double? reviewsAvgService,@JsonKey(name: 'reviews_avg_ambience') double? reviewsAvgAmbience,@JsonKey(name: 'user_review') Review? userReview
});


@override $CategoryCopyWith<$Res> get primaryCategory;@override $ReviewCopyWith<$Res>? get userReview;

}
/// @nodoc
class __$EstablishmentDetailCopyWithImpl<$Res>
    implements _$EstablishmentDetailCopyWith<$Res> {
  __$EstablishmentDetailCopyWithImpl(this._self, this._then);

  final _EstablishmentDetail _self;
  final $Res Function(_EstablishmentDetail) _then;

/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? description = freezed,Object? phone = freezed,Object? whatsapp = freezed,Object? whatsappUrl = freezed,Object? instagram = freezed,Object? instagramUrl = freezed,Object? address = null,Object? neighborhood = null,Object? latitude = null,Object? longitude = null,Object? coverPhotoUrl = freezed,Object? primaryCategory = null,Object? categories = null,Object? features = null,Object? businessHours = null,Object? isOpenNow = null,Object? currentStatusMessage = null,Object? photosCount = null,Object? reviewsCount = null,Object? reviewsAvgRating = freezed,Object? reviewsAvgFood = freezed,Object? reviewsAvgService = freezed,Object? reviewsAvgAmbience = freezed,Object? userReview = freezed,}) {
  return _then(_EstablishmentDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,whatsapp: freezed == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String?,whatsappUrl: freezed == whatsappUrl ? _self.whatsappUrl : whatsappUrl // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,instagramUrl: freezed == instagramUrl ? _self.instagramUrl : instagramUrl // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,primaryCategory: null == primaryCategory ? _self.primaryCategory : primaryCategory // ignore: cast_nullable_to_non_nullable
as Category,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<Feature>,businessHours: null == businessHours ? _self._businessHours : businessHours // ignore: cast_nullable_to_non_nullable
as List<BusinessHour>,isOpenNow: null == isOpenNow ? _self.isOpenNow : isOpenNow // ignore: cast_nullable_to_non_nullable
as bool,currentStatusMessage: null == currentStatusMessage ? _self.currentStatusMessage : currentStatusMessage // ignore: cast_nullable_to_non_nullable
as String,photosCount: null == photosCount ? _self.photosCount : photosCount // ignore: cast_nullable_to_non_nullable
as int,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,reviewsAvgRating: freezed == reviewsAvgRating ? _self.reviewsAvgRating : reviewsAvgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgFood: freezed == reviewsAvgFood ? _self.reviewsAvgFood : reviewsAvgFood // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgService: freezed == reviewsAvgService ? _self.reviewsAvgService : reviewsAvgService // ignore: cast_nullable_to_non_nullable
as double?,reviewsAvgAmbience: freezed == reviewsAvgAmbience ? _self.reviewsAvgAmbience : reviewsAvgAmbience // ignore: cast_nullable_to_non_nullable
as double?,userReview: freezed == userReview ? _self.userReview : userReview // ignore: cast_nullable_to_non_nullable
as Review?,
  ));
}

/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get primaryCategory {
  
  return $CategoryCopyWith<$Res>(_self.primaryCategory, (value) {
    return _then(_self.copyWith(primaryCategory: value));
  });
}/// Create a copy of EstablishmentDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewCopyWith<$Res>? get userReview {
    if (_self.userReview == null) {
    return null;
  }

  return $ReviewCopyWith<$Res>(_self.userReview!, (value) {
    return _then(_self.copyWith(userReview: value));
  });
}
}

// dart format on
