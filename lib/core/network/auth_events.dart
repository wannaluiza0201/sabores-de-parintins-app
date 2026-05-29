import 'dart:async';

/// Stream global pra eventos de auth que vêm do interceptor.
///
/// POR QUE: o `AuthInterceptor` precisa avisar o `authStateProvider`
/// quando o backend retorna 401 (token revogado/expirado). Se o
/// interceptor importasse `auth_providers.dart` haveria ciclo:
/// dio_client → auth_providers → repository → auth_api_service → dio.
///
/// SOLUÇÃO: o interceptor publica num stream e o provider escuta,
/// sem import cruzado.
class AuthEvents {
  AuthEvents._();

  static final _controller = StreamController<void>.broadcast();

  /// Escuta no `auth_providers.dart` (Notifier.build) pra forçar
  /// status = unauthenticated.
  static Stream<void> get unauthorized => _controller.stream;

  /// Chamado pelo AuthInterceptor no `onError` quando status == 401.
  static void notifyUnauthorized() => _controller.add(null);
}
