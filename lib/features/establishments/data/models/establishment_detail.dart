import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../reviews/data/models/review.dart';
import 'business_hour.dart';
import 'category.dart';
import 'feature.dart';

part 'establishment_detail.freezed.dart';
part 'establishment_detail.g.dart';

/// Resposta de `GET /api/v1/establishments/{slug}` — forma rica (vs. forma
/// de lista em `Establishment`).
///
/// Inclui campos de contato (whatsapp/instagram com URLs prontas),
/// features, business_hours e current_status_message — todos opcionais.
///
/// CONVENÇÃO DA API: campos opcionais podem vir como `""` OU `null`,
/// dependendo do estabelecimento. Por segurança, todo campo de contato
/// é nullable e a UI normaliza com `??` ou `?.isNotEmpty ?? false`.
@freezed
abstract class EstablishmentDetail with _$EstablishmentDetail {
  const factory EstablishmentDetail({
    required int id,
    required String slug,
    required String name,
    String? description,
    String? phone,
    String? whatsapp,
    @JsonKey(name: 'whatsapp_url') String? whatsappUrl,
    String? instagram,
    @JsonKey(name: 'instagram_url') String? instagramUrl,
    required String address,
    required String neighborhood,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,
    @JsonKey(name: 'primary_category') required Category primaryCategory,
    required List<Category> categories,
    required List<Feature> features,
    @JsonKey(name: 'business_hours') required List<BusinessHour> businessHours,
    @JsonKey(name: 'is_open_now') required bool isOpenNow,
    @JsonKey(name: 'current_status_message')
    required String currentStatusMessage,
    @JsonKey(name: 'photos_count') required int photosCount,
    // Agregados de reviews — sempre presentes (defaults se backend mudar).
    @JsonKey(name: 'reviews_count') @Default(0) int reviewsCount,
    @JsonKey(name: 'reviews_avg_rating') double? reviewsAvgRating,
    @JsonKey(name: 'reviews_avg_food') double? reviewsAvgFood,
    @JsonKey(name: 'reviews_avg_service') double? reviewsAvgService,
    @JsonKey(name: 'reviews_avg_ambience') double? reviewsAvgAmbience,
    // Review do usuário atual (qualquer status). null se não avaliou
    // OU se a request foi anônima (campo omitido).
    @JsonKey(name: 'user_review') Review? userReview,
  }) = _EstablishmentDetail;

  factory EstablishmentDetail.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentDetailFromJson(json);
}
