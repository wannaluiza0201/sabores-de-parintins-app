import 'package:dio/dio.dart';

import '../../features/auth/data/services/secure_storage_service.dart';
import 'auth_events.dart';

/// Interceptor de auth — duas responsabilidades:
/// 1. `onRequest`: lê o token do SecureStorage e anexa `Authorization`
///    em TODAS as requests, exceto `/auth/google` (que não tem token
///    ainda — é a request que troca id_token por Sanctum token).
/// 2. `onError`: detecta 401, limpa storage e publica evento global
///    `AuthEvents.notifyUnauthorized()` pra o provider reagir.
///
/// Manter tudo aqui (não no AuthRepository) faz com que QUALQUER
/// request expirada por token derrube o login automaticamente — sem
/// cada service ter que tratar manualmente.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);

  final SecureStorageService _storage;

  // Rotas que NÃO levam Bearer (não precisam OU não podem ter).
  static const _publicAuthPaths = ['/auth/google'];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Não bloqueia o /auth/google — token nem existe nesse ponto.
    final isPublicAuth = _publicAuthPaths.any(options.path.endsWith);
    if (!isPublicAuth) {
      final token = await _storage.readToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Limpa local imediatamente — token não vale mais.
      await _storage.clear();
      // Notifica o provider. UI reage e mostra tela "Entre com Google".
      AuthEvents.notifyUnauthorized();
    }
    handler.next(err);
  }
}
