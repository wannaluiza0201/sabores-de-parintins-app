// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstablishmentDetail _$EstablishmentDetailFromJson(Map<String, dynamic> json) =>
    _EstablishmentDetail(
      id: (json['id'] as num).toInt(),
      slug: json['slug'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      whatsappUrl: json['whatsapp_url'] as String?,
      instagram: json['instagram'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      address: json['address'] as String,
      neighborhood: json['neighborhood'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      coverPhotoUrl: json['cover_photo_url'] as String?,
      primaryCategory: Category.fromJson(
        json['primary_category'] as Map<String, dynamic>,
      ),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      features: (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
      businessHours: (json['business_hours'] as List<dynamic>)
          .map((e) => BusinessHour.fromJson(e as Map<String, dynamic>))
          .toList(),
      isOpenNow: json['is_open_now'] as bool,
      currentStatusMessage: json['current_status_message'] as String,
      photosCount: (json['photos_count'] as num).toInt(),
      reviewsCount: (json['reviews_count'] as num?)?.toInt() ?? 0,
      reviewsAvgRating: (json['reviews_avg_rating'] as num?)?.toDouble(),
      reviewsAvgFood: (json['reviews_avg_food'] as num?)?.toDouble(),
      reviewsAvgService: (json['reviews_avg_service'] as num?)?.toDouble(),
      reviewsAvgAmbience: (json['reviews_avg_ambience'] as num?)?.toDouble(),
      userReview: json['user_review'] == null
          ? null
          : Review.fromJson(json['user_review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EstablishmentDetailToJson(
  _EstablishmentDetail instance,
) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
  'description': instance.description,
  'phone': instance.phone,
  'whatsapp': instance.whatsapp,
  'whatsapp_url': instance.whatsappUrl,
  'instagram': instance.instagram,
  'instagram_url': instance.instagramUrl,
  'address': instance.address,
  'neighborhood': instance.neighborhood,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'cover_photo_url': instance.coverPhotoUrl,
  'primary_category': instance.primaryCategory,
  'categories': instance.categories,
  'features': instance.features,
  'business_hours': instance.businessHours,
  'is_open_now': instance.isOpenNow,
  'current_status_message': instance.currentStatusMessage,
  'photos_count': instance.photosCount,
  'reviews_count': instance.reviewsCount,
  'reviews_avg_rating': instance.reviewsAvgRating,
  'reviews_avg_food': instance.reviewsAvgFood,
  'reviews_avg_service': instance.reviewsAvgService,
  'reviews_avg_ambience': instance.reviewsAvgAmbience,
  'user_review': instance.userReview,
};
