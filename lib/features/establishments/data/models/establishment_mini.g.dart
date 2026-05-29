// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_mini.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstablishmentMini _$EstablishmentMiniFromJson(Map<String, dynamic> json) =>
    _EstablishmentMini(
      id: (json['id'] as num).toInt(),
      slug: json['slug'] as String,
      name: json['name'] as String,
      coverPhotoUrl: json['cover_photo_url'] as String?,
      primaryCategory: Category.fromJson(
        json['primary_category'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$EstablishmentMiniToJson(_EstablishmentMini instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'cover_photo_url': instance.coverPhotoUrl,
      'primary_category': instance.primaryCategory,
    };
