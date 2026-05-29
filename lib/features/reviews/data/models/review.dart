import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../establishments/data/models/establishment_mini.dart';

part 'review.freezed.dart';
part 'review.g.dart';

/// Status de moderação de uma avaliação. Vem do backend como string.
/// Pra UI, mapear pra badge/copy adequado em `ReviewStatusX` (extensão
/// no arquivo de widgets).
enum ReviewStatus {
  @JsonValue('visible')
  visible,
  @JsonValue('pending')
  pending,
  @JsonValue('hidden')
  hidden,
  @JsonValue('rejected')
  rejected,
}

/// Autor da review — subset do AuthUser (vem embedded).
@freezed
abstract class ReviewAuthor with _$ReviewAuthor {
  const factory ReviewAuthor({
    required int id,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ReviewAuthor;

  factory ReviewAuthor.fromJson(Map<String, dynamic> json) =>
      _$ReviewAuthorFromJson(json);
}

/// Review única.
///
/// `establishment` só vem preenchido em `/me/reviews`. Nas listas
/// de um estabelecimento específico, é null (já se sabe qual é).
@freezed
abstract class Review with _$Review {
  const factory Review({
    required int id,
    required int rating,
    @JsonKey(name: 'rating_food') int? ratingFood,
    @JsonKey(name: 'rating_service') int? ratingService,
    @JsonKey(name: 'rating_ambience') int? ratingAmbience,
    String? comment,
    required ReviewStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    // `user` é OMITIDO em /me/reviews (autor é o próprio user logado —
    // redundante). Em listas públicas sempre vem preenchido. UI usa
    // fallback "Usuário" se null.
    ReviewAuthor? user,
    // Só presente em /me/reviews. Em listas por estabelecimento é null.
    // Tipo mini (4-5 campos) porque o backend só envia subset embedded —
    // tentar parsear como Establishment full explodiria em required.
    EstablishmentMini? establishment,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

// ============================================================
// Inputs — usados pelo Notifier de submissão, NÃO vêm da API.
// Sem freezed (são DTOs locais) — toJson manual.
// ============================================================

/// Payload pra POST/PUT em reviews.
class ReviewInput {
  const ReviewInput({
    required this.rating,
    this.ratingFood,
    this.ratingService,
    this.ratingAmbience,
    this.comment,
  });

  final int rating; // 1-5
  final int? ratingFood;
  final int? ratingService;
  final int? ratingAmbience;
  final String? comment;

  /// PUT é estrito: campos omitidos viram null no backend. Por isso
  /// SEMPRE enviamos todos os 4 ratings + comment (mesmo que null).
  Map<String, dynamic> toJson() => {
        'rating': rating,
        'rating_food': ratingFood,
        'rating_service': ratingService,
        'rating_ambience': ratingAmbience,
        'comment': comment,
      };
}

/// Motivos de denúncia — bate com o enum do backend.
enum ReportReason {
  spam('spam', 'Spam / propaganda'),
  offensive('offensive', 'Conteúdo ofensivo'),
  fake('fake', 'Informação falsa'),
  offTopic('off_topic', 'Fora de contexto'),
  other('other', 'Outro');

  const ReportReason(this.apiValue, this.label);
  final String apiValue;
  final String label;
}

class ReportInput {
  const ReportInput({required this.reason, this.notes});
  final ReportReason reason;
  final String? notes;

  Map<String, dynamic> toJson() => {
        'reason': reason.apiValue,
        if (notes != null && notes!.isNotEmpty) 'notes': notes,
      };
}
