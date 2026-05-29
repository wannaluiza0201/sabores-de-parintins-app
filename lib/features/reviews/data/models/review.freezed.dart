// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewAuthor {

 int get id; String get name;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of ReviewAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewAuthorCopyWith<ReviewAuthor> get copyWith => _$ReviewAuthorCopyWithImpl<ReviewAuthor>(this as ReviewAuthor, _$identity);

  /// Serializes this ReviewAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ReviewAuthor(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $ReviewAuthorCopyWith<$Res>  {
  factory $ReviewAuthorCopyWith(ReviewAuthor value, $Res Function(ReviewAuthor) _then) = _$ReviewAuthorCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$ReviewAuthorCopyWithImpl<$Res>
    implements $ReviewAuthorCopyWith<$Res> {
  _$ReviewAuthorCopyWithImpl(this._self, this._then);

  final ReviewAuthor _self;
  final $Res Function(ReviewAuthor) _then;

/// Create a copy of ReviewAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewAuthor].
extension ReviewAuthorPatterns on ReviewAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewAuthor value)  $default,){
final _that = this;
switch (_that) {
case _ReviewAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewAuthor() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _ReviewAuthor():
return $default(_that.id,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _ReviewAuthor() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewAuthor implements ReviewAuthor {
  const _ReviewAuthor({required this.id, required this.name, @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _ReviewAuthor.fromJson(Map<String, dynamic> json) => _$ReviewAuthorFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of ReviewAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewAuthorCopyWith<_ReviewAuthor> get copyWith => __$ReviewAuthorCopyWithImpl<_ReviewAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl);

@override
String toString() {
  return 'ReviewAuthor(id: $id, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$ReviewAuthorCopyWith<$Res> implements $ReviewAuthorCopyWith<$Res> {
  factory _$ReviewAuthorCopyWith(_ReviewAuthor value, $Res Function(_ReviewAuthor) _then) = __$ReviewAuthorCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$ReviewAuthorCopyWithImpl<$Res>
    implements _$ReviewAuthorCopyWith<$Res> {
  __$ReviewAuthorCopyWithImpl(this._self, this._then);

  final _ReviewAuthor _self;
  final $Res Function(_ReviewAuthor) _then;

/// Create a copy of ReviewAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_ReviewAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Review {

 int get id; int get rating;@JsonKey(name: 'rating_food') int? get ratingFood;@JsonKey(name: 'rating_service') int? get ratingService;@JsonKey(name: 'rating_ambience') int? get ratingAmbience; String? get comment; ReviewStatus get status;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;// `user` é OMITIDO em /me/reviews (autor é o próprio user logado —
// redundante). Em listas públicas sempre vem preenchido. UI usa
// fallback "Usuário" se null.
 ReviewAuthor? get user;// Só presente em /me/reviews. Em listas por estabelecimento é null.
// Tipo mini (4-5 campos) porque o backend só envia subset embedded —
// tentar parsear como Establishment full explodiria em required.
 EstablishmentMini? get establishment;
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewCopyWith<Review> get copyWith => _$ReviewCopyWithImpl<Review>(this as Review, _$identity);

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Review&&(identical(other.id, id) || other.id == id)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingFood, ratingFood) || other.ratingFood == ratingFood)&&(identical(other.ratingService, ratingService) || other.ratingService == ratingService)&&(identical(other.ratingAmbience, ratingAmbience) || other.ratingAmbience == ratingAmbience)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.establishment, establishment) || other.establishment == establishment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rating,ratingFood,ratingService,ratingAmbience,comment,status,createdAt,updatedAt,user,establishment);

@override
String toString() {
  return 'Review(id: $id, rating: $rating, ratingFood: $ratingFood, ratingService: $ratingService, ratingAmbience: $ratingAmbience, comment: $comment, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, establishment: $establishment)';
}


}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res>  {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) = _$ReviewCopyWithImpl;
@useResult
$Res call({
 int id, int rating,@JsonKey(name: 'rating_food') int? ratingFood,@JsonKey(name: 'rating_service') int? ratingService,@JsonKey(name: 'rating_ambience') int? ratingAmbience, String? comment, ReviewStatus status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, ReviewAuthor? user, EstablishmentMini? establishment
});


$ReviewAuthorCopyWith<$Res>? get user;$EstablishmentMiniCopyWith<$Res>? get establishment;

}
/// @nodoc
class _$ReviewCopyWithImpl<$Res>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rating = null,Object? ratingFood = freezed,Object? ratingService = freezed,Object? ratingAmbience = freezed,Object? comment = freezed,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? user = freezed,Object? establishment = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,ratingFood: freezed == ratingFood ? _self.ratingFood : ratingFood // ignore: cast_nullable_to_non_nullable
as int?,ratingService: freezed == ratingService ? _self.ratingService : ratingService // ignore: cast_nullable_to_non_nullable
as int?,ratingAmbience: freezed == ratingAmbience ? _self.ratingAmbience : ratingAmbience // ignore: cast_nullable_to_non_nullable
as int?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ReviewAuthor?,establishment: freezed == establishment ? _self.establishment : establishment // ignore: cast_nullable_to_non_nullable
as EstablishmentMini?,
  ));
}
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewAuthorCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ReviewAuthorCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstablishmentMiniCopyWith<$Res>? get establishment {
    if (_self.establishment == null) {
    return null;
  }

  return $EstablishmentMiniCopyWith<$Res>(_self.establishment!, (value) {
    return _then(_self.copyWith(establishment: value));
  });
}
}


/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Review value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Review value)  $default,){
final _that = this;
switch (_that) {
case _Review():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Review value)?  $default,){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int rating, @JsonKey(name: 'rating_food')  int? ratingFood, @JsonKey(name: 'rating_service')  int? ratingService, @JsonKey(name: 'rating_ambience')  int? ratingAmbience,  String? comment,  ReviewStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  ReviewAuthor? user,  EstablishmentMini? establishment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.rating,_that.ratingFood,_that.ratingService,_that.ratingAmbience,_that.comment,_that.status,_that.createdAt,_that.updatedAt,_that.user,_that.establishment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int rating, @JsonKey(name: 'rating_food')  int? ratingFood, @JsonKey(name: 'rating_service')  int? ratingService, @JsonKey(name: 'rating_ambience')  int? ratingAmbience,  String? comment,  ReviewStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  ReviewAuthor? user,  EstablishmentMini? establishment)  $default,) {final _that = this;
switch (_that) {
case _Review():
return $default(_that.id,_that.rating,_that.ratingFood,_that.ratingService,_that.ratingAmbience,_that.comment,_that.status,_that.createdAt,_that.updatedAt,_that.user,_that.establishment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int rating, @JsonKey(name: 'rating_food')  int? ratingFood, @JsonKey(name: 'rating_service')  int? ratingService, @JsonKey(name: 'rating_ambience')  int? ratingAmbience,  String? comment,  ReviewStatus status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  ReviewAuthor? user,  EstablishmentMini? establishment)?  $default,) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.rating,_that.ratingFood,_that.ratingService,_that.ratingAmbience,_that.comment,_that.status,_that.createdAt,_that.updatedAt,_that.user,_that.establishment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Review implements Review {
  const _Review({required this.id, required this.rating, @JsonKey(name: 'rating_food') this.ratingFood, @JsonKey(name: 'rating_service') this.ratingService, @JsonKey(name: 'rating_ambience') this.ratingAmbience, this.comment, required this.status, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, this.user, this.establishment});
  factory _Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

@override final  int id;
@override final  int rating;
@override@JsonKey(name: 'rating_food') final  int? ratingFood;
@override@JsonKey(name: 'rating_service') final  int? ratingService;
@override@JsonKey(name: 'rating_ambience') final  int? ratingAmbience;
@override final  String? comment;
@override final  ReviewStatus status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
// `user` é OMITIDO em /me/reviews (autor é o próprio user logado —
// redundante). Em listas públicas sempre vem preenchido. UI usa
// fallback "Usuário" se null.
@override final  ReviewAuthor? user;
// Só presente em /me/reviews. Em listas por estabelecimento é null.
// Tipo mini (4-5 campos) porque o backend só envia subset embedded —
// tentar parsear como Establishment full explodiria em required.
@override final  EstablishmentMini? establishment;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewCopyWith<_Review> get copyWith => __$ReviewCopyWithImpl<_Review>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review&&(identical(other.id, id) || other.id == id)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingFood, ratingFood) || other.ratingFood == ratingFood)&&(identical(other.ratingService, ratingService) || other.ratingService == ratingService)&&(identical(other.ratingAmbience, ratingAmbience) || other.ratingAmbience == ratingAmbience)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.establishment, establishment) || other.establishment == establishment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rating,ratingFood,ratingService,ratingAmbience,comment,status,createdAt,updatedAt,user,establishment);

@override
String toString() {
  return 'Review(id: $id, rating: $rating, ratingFood: $ratingFood, ratingService: $ratingService, ratingAmbience: $ratingAmbience, comment: $comment, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, establishment: $establishment)';
}


}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) = __$ReviewCopyWithImpl;
@override @useResult
$Res call({
 int id, int rating,@JsonKey(name: 'rating_food') int? ratingFood,@JsonKey(name: 'rating_service') int? ratingService,@JsonKey(name: 'rating_ambience') int? ratingAmbience, String? comment, ReviewStatus status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, ReviewAuthor? user, EstablishmentMini? establishment
});


@override $ReviewAuthorCopyWith<$Res>? get user;@override $EstablishmentMiniCopyWith<$Res>? get establishment;

}
/// @nodoc
class __$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rating = null,Object? ratingFood = freezed,Object? ratingService = freezed,Object? ratingAmbience = freezed,Object? comment = freezed,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? user = freezed,Object? establishment = freezed,}) {
  return _then(_Review(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,ratingFood: freezed == ratingFood ? _self.ratingFood : ratingFood // ignore: cast_nullable_to_non_nullable
as int?,ratingService: freezed == ratingService ? _self.ratingService : ratingService // ignore: cast_nullable_to_non_nullable
as int?,ratingAmbience: freezed == ratingAmbience ? _self.ratingAmbience : ratingAmbience // ignore: cast_nullable_to_non_nullable
as int?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ReviewAuthor?,establishment: freezed == establishment ? _self.establishment : establishment // ignore: cast_nullable_to_non_nullable
as EstablishmentMini?,
  ));
}

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewAuthorCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ReviewAuthorCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstablishmentMiniCopyWith<$Res>? get establishment {
    if (_self.establishment == null) {
    return null;
  }

  return $EstablishmentMiniCopyWith<$Res>(_self.establishment!, (value) {
    return _then(_self.copyWith(establishment: value));
  });
}
}

// dart format on
