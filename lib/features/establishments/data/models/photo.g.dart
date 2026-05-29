// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Photo _$PhotoFromJson(Map<String, dynamic> json) => _Photo(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  caption: json['caption'] as String?,
  sortOrder: (json['sort_order'] as num).toInt(),
);

Map<String, dynamic> _$PhotoToJson(_Photo instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'caption': instance.caption,
  'sort_order': instance.sortOrder,
};
