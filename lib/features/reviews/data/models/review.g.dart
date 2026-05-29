// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewAuthor _$ReviewAuthorFromJson(Map<String, dynamic> json) =>
    _ReviewAuthor(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$ReviewAuthorToJson(_ReviewAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: (json['id'] as num).toInt(),
  rating: (json['rating'] as num).toInt(),
  ratingFood: (json['rating_food'] as num?)?.toInt(),
  ratingService: (json['rating_service'] as num?)?.toInt(),
  ratingAmbience: (json['rating_ambience'] as num?)?.toInt(),
  comment: json['comment'] as String?,
  status: $enumDecode(_$ReviewStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  user: json['user'] == null
      ? null
      : ReviewAuthor.fromJson(json['user'] as Map<String, dynamic>),
  establishment: json['establishment'] == null
      ? null
      : EstablishmentMini.fromJson(
          json['establishment'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'rating': instance.rating,
  'rating_food': instance.ratingFood,
  'rating_service': instance.ratingService,
  'rating_ambience': instance.ratingAmbience,
  'comment': instance.comment,
  'status': _$ReviewStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'user': instance.user,
  'establishment': instance.establishment,
};

const _$ReviewStatusEnumMap = {
  ReviewStatus.visible: 'visible',
  ReviewStatus.pending: 'pending',
  ReviewStatus.hidden: 'hidden',
  ReviewStatus.rejected: 'rejected',
};
