// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessHour _$BusinessHourFromJson(Map<String, dynamic> json) =>
    _BusinessHour(
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      dayName: json['day_name'] as String,
      opensAt: json['opens_at'] as String?,
      closesAt: json['closes_at'] as String?,
      isClosed: json['is_closed'] as bool,
      crossesMidnight: json['crosses_midnight'] as bool,
    );

Map<String, dynamic> _$BusinessHourToJson(_BusinessHour instance) =>
    <String, dynamic>{
      'day_of_week': instance.dayOfWeek,
      'day_name': instance.dayName,
      'opens_at': instance.opensAt,
      'closes_at': instance.closesAt,
      'is_closed': instance.isClosed,
      'crosses_midnight': instance.crossesMidnight,
    };
