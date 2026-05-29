import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_hour.freezed.dart';
part 'business_hour.g.dart';

/// Horário de funcionamento de um dia da semana.
/// `day_of_week`: 0=Domingo, 1=Segunda, ..., 6=Sábado (convenção do backend).
///
/// `opens_at` e `closes_at` podem vir `null` se `is_closed = true` — por isso
/// marcados nullable mesmo aparecendo na amostra atual sempre preenchidos.
/// `crosses_midnight = true` indica que o horário atravessa meia-noite
/// (ex.: abre 20:00 e fecha 02:00 do dia seguinte).
@freezed
abstract class BusinessHour with _$BusinessHour {
  const factory BusinessHour({
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'day_name') required String dayName,
    @JsonKey(name: 'opens_at') String? opensAt,
    @JsonKey(name: 'closes_at') String? closesAt,
    @JsonKey(name: 'is_closed') required bool isClosed,
    @JsonKey(name: 'crosses_midnight') required bool crossesMidnight,
  }) = _BusinessHour;

  factory BusinessHour.fromJson(Map<String, dynamic> json) =>
      _$BusinessHourFromJson(json);
}
