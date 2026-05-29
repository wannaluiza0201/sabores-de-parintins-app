import 'package:freezed_annotation/freezed_annotation.dart';

import 'category.dart';

part 'establishment.freezed.dart';
part 'establishment.g.dart';

/// Estabelecimento conforme retornado por `GET /api/v1/establishments`
/// (forma de lista). A forma de detalhe (`/establishments/{slug}`) traz
/// campos adicionais — modelar separadamente quando criarmos a tela de
/// detalhe.
@freezed
abstract class Establishment with _$Establishment {
  const factory Establishment({
    required int id,
    required String slug,
    required String name,
    // Nullable: o backend permite estabelecimento sem descrição.
    String? description,
    @JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,
    @JsonKey(name: 'primary_category') required Category primaryCategory,
    required List<Category> categories,
    required String neighborhood,
    required String address,
    @JsonKey(name: 'is_open_now') required bool isOpenNow,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'distance_km') double? distanceKm,
    // Vem `true`/`false` quando há Bearer token; o campo é OMITIDO
    // pra requests anônimas — por isso `bool?` (e não default `false`,
    // pra distinguir "anônimo = desconhecido" de "logado = não favoritou").
    @JsonKey(name: 'is_favorited') bool? isFavorited,
    // Agregados de reviews — sempre presentes nos endpoints (defaults
    // garantem comportamento estável mesmo se o backend mudar). Avgs
    // viram null quando count == 0.
    @JsonKey(name: 'reviews_count') @Default(0) int reviewsCount,
    @JsonKey(name: 'reviews_avg_rating') double? reviewsAvgRating,
    @JsonKey(name: 'reviews_avg_food') double? reviewsAvgFood,
    @JsonKey(name: 'reviews_avg_service') double? reviewsAvgService,
    @JsonKey(name: 'reviews_avg_ambience') double? reviewsAvgAmbience,
  }) = _Establishment;

  factory Establishment.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentFromJson(json);
}
