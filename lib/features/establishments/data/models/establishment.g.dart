// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Establishment _$EstablishmentFromJson(Map<String, dynamic> json) =>
    _Establishment(
      id: (json['id'] as num).toInt(),
      slug: json['slug'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      coverPhotoUrl: json['cover_photo_url'] as String?,
      primaryCategory: Category.fromJson(
        json['primary_category'] as Map<String, dynamic>,
      ),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      neighborhood: json['neighborhood'] as String,
      address: json['address'] as String,
      isOpenNow: json['is_open_now'] as bool,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
      isFavorited: json['is_favorited'] as bool?,
      reviewsCount: (json['reviews_count'] as num?)?.toInt() ?? 0,
      reviewsAvgRating: (json['reviews_avg_rating'] as num?)?.toDouble(),
      reviewsAvgFood: (json['reviews_avg_food'] as num?)?.toDouble(),
      reviewsAvgService: (json['reviews_avg_service'] as num?)?.toDouble(),
      reviewsAvgAmbience: (json['reviews_avg_ambience'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EstablishmentToJson(_Establishment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'description': instance.description,
      'cover_photo_url': instance.coverPhotoUrl,
      'primary_category': instance.primaryCategory,
      'categories': instance.categories,
      'neighborhood': instance.neighborhood,
      'address': instance.address,
      'is_open_now': instance.isOpenNow,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance_km': instance.distanceKm,
      'is_favorited': instance.isFavorited,
      'reviews_count': instance.reviewsCount,
      'reviews_avg_rating': instance.reviewsAvgRating,
      'reviews_avg_food': instance.reviewsAvgFood,
      'reviews_avg_service': instance.reviewsAvgService,
      'reviews_avg_ambience': instance.reviewsAvgAmbience,
    };
