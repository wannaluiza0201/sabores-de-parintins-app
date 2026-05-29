import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature.freezed.dart';
part 'feature.g.dart';

/// Comodidade do estabelecimento (Wi-Fi, ar-condicionado, aceita Pix, etc.).
/// Vem dentro de `EstablishmentDetail.features` em `/establishments/{slug}`.
///
/// O campo `icon` da API hoje vem `null` em todos — usamos o `slug` no app
/// pra mapear pro `IconData` correspondente.
@freezed
abstract class Feature with _$Feature {
  const factory Feature({
    required int id,
    required String name,
    required String slug,
    String? icon,
  }) = _Feature;

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
}
