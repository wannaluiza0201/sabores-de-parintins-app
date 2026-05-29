import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/network/paginated_response.dart';
import '../models/review.dart';

// ============================================================
// Exceções tipadas — UI usa pra dar feedback adequado em cada caso.
// ============================================================

/// 409 no POST de review: o user já avaliou esse estabelecimento.
/// Tratamento esperado na UI: fechar form e reabrir em modo edição.
class DuplicateReviewException implements Exception {
  const DuplicateReviewException();
  @override
  String toString() => 'DuplicateReviewException';
}

/// 422 em POST/PUT/report: validation do backend falhou. `fieldErrors`
/// vem no formato Laravel padrão (`{field: [msg1, msg2]}`).
class ValidationException implements Exception {
  const ValidationException({this.message, this.fieldErrors = const {}});
  final String? message;
  final Map<String, List<String>> fieldErrors;

  /// Atalho pra pegar a primeira mensagem de um campo (UI inline).
  String? firstErrorFor(String field) {
    final list = fieldErrors[field];
    return (list != null && list.isNotEmpty) ? list.first : null;
  }

  @override
  String toString() =>
      'ValidationException(message: $message, fields: ${fieldErrors.keys.toList()})';
}

// ============================================================
// Repository
// ============================================================

class ReviewsRepository {
  ReviewsRepository(this._dio);

  final Dio _dio;

  /// `GET /establishments/{slug}/reviews` — público, paginado 15/página,
  /// só status visible, ordem `created_at DESC`.
  Future<PaginatedResponse<Review>> getEstablishmentReviews(
    String slug, {
    int page = 1,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/establishments/$slug/reviews',
      queryParameters: {'page': page},
    );
    return PaginatedResponse.fromJson(res.data!, Review.fromJson);
  }

  /// `POST /establishments/{slug}/reviews` — autenticado.
  /// Lança `DuplicateReviewException` em 409, `ValidationException` em 422.
  Future<Review> createReview(String slug, ReviewInput input) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/establishments/$slug/reviews',
        data: input.toJson(),
      );
      return _unwrapReview(res.data!);
    } on DioException catch (e) {
      _throwIfKnownError(e);
    }
  }

  /// `PUT /reviews/{id}` — só o dono. PUT estrito: enviar SEMPRE todos
  /// os campos (o `ReviewInput.toJson()` cuida disso).
  Future<Review> updateReview(int id, ReviewInput input) async {
    try {
      final res = await _dio.put<Map<String, dynamic>>(
        '/reviews/$id',
        data: input.toJson(),
      );
      return _unwrapReview(res.data!);
    } on DioException catch (e) {
      _throwIfKnownError(e);
    }
  }

  /// `DELETE /reviews/{id}` — só o dono. 204 esperado.
  Future<void> deleteReview(int id) async {
    await _dio.delete('/reviews/$id');
  }

  /// `GET /me/reviews` — autenticado, paginado, TODOS os status,
  /// com `establishment` embedded em cada item.
  Future<PaginatedResponse<Review>> getMyReviews({int page = 1}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/me/reviews',
      queryParameters: {'page': page},
    );
    return PaginatedResponse.fromJson(res.data!, Review.fromJson);
  }

  /// `POST /reviews/{id}/report` — autenticado, idempotente.
  /// 422 ao denunciar a própria review (tratado como ValidationException
  /// — UI mostra mensagem do backend).
  Future<void> reportReview(int reviewId, ReportInput input) async {
    try {
      await _dio.post('/reviews/$reviewId/report', data: input.toJson());
    } on DioException catch (e) {
      _throwIfKnownError(e);
    }
  }

  // ============================================================
  // Helpers
  // ============================================================

  /// Backend Laravel wrap com `{data: {...}}` (JsonResource). Defensivo
  /// pra também aceitar o objeto direto.
  Review _unwrapReview(Map<String, dynamic> body) {
    final data = (body['data'] ?? body) as Map<String, dynamic>;
    return Review.fromJson(data);
  }

  /// `Never` sinaliza pro compilador "este método SEMPRE lança". Sem
  /// `return` no fim do caller — Dart já sabe que o fluxo termina aqui.
  Never _throwIfKnownError(DioException e) {
    final status = e.response?.statusCode;

    if (status == 409) {
      throw const DuplicateReviewException();
    }

    if (status == 422) {
      final data = e.response?.data;
      String? message;
      Map<String, List<String>> errors = const {};
      if (data is Map<String, dynamic>) {
        message = data['message'] as String?;
        final rawErrors = data['errors'];
        if (rawErrors is Map) {
          errors = rawErrors.map((k, v) {
            final list = v is List
                ? v.map((x) => x.toString()).toList()
                : <String>[v.toString()];
            return MapEntry(k.toString(), list);
          });
        }
      }
      throw ValidationException(message: message, fieldErrors: errors);
    }

    // Outros DioExceptions (timeout, 500, sem rede, etc.) sobem
    // inalterados — UI mostra SnackBar genérico.
    throw e;
  }
}

/// Singleton — reusa o Dio compartilhado (já com AuthInterceptor).
final reviewsRepositoryProvider = Provider<ReviewsRepository>((ref) {
  return ReviewsRepository(ref.watch(dioProvider));
});
