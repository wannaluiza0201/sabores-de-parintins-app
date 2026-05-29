// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BannerItem _$BannerItemFromJson(Map<String, dynamic> json) => _BannerItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  imageUrl: json['image_url'] as String?,
  linkUrl: json['link_url'] as String?,
);

Map<String, dynamic> _$BannerItemToJson(_BannerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'link_url': instance.linkUrl,
    };
