import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/network/paginated_response.dart';
import '../../../establishments/data/models/establishment.dart';

/// Repositório dedicado a favoritos.
///
/// Separado do EstablishmentRepository por isolamento: favoritos é uma
/// feature opcional e tem dependências (auth) que o repo de
/// estabelecimentos não tem. Mantém a regra de "uma classe, uma razão
/// pra mudar".
class FavoritesRepository {
  FavoritesRepository(this._dio);

  final Dio _dio;

  /// `POST /establishments/{slug}/favorite` — idempotente.
  /// Retorna o valor de `favorited` do response (será sempre `true`,
  /// mas devolvemos pra deixar o caller decidir o que fazer).
  Future<bool> favorite(String slug) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/establishments/$slug/favorite',
    );
    return (response.data?['favorited'] as bool?) ?? true;
  }

  /// `DELETE /establishments/{slug}/favorite` — idempotente.
  Future<bool> unfavorite(String slug) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/establishments/$slug/favorite',
    );
    // Em DELETE bem-sucedido, `favorited` vem false.
    return (response.data?['favorited'] as bool?) ?? false;
  }

  /// `GET /favorites?page=N` — paginado (15/página no backend).
  Future<PaginatedResponse<Establishment>> getFavorites({int page = 1}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/favorites',
      queryParameters: {'page': page},
    );
    return PaginatedResponse.fromJson(response.data!, Establishment.fromJson);
  }
}

/// Singleton — reusa o mesmo Dio (com AuthInterceptor) do app.
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository(ref.watch(dioProvider));
});
