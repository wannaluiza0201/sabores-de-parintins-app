import 'package:dio/dio.dart';

/// Cliente HTTP para o endpoint de registro de FCM tokens no backend.
///
/// Endpoint: `POST /device-tokens` (base já tem `/api/v1`).
/// Body: `{ token, platform }`.
///
/// O `Authorization: Bearer` é anexado AUTOMATICAMENTE pelo
/// `AuthInterceptor` (lib/core/network/auth_interceptor.dart) quando há
/// token Sanctum no SecureStorage. Por isso esta classe NÃO precisa
/// saber sobre auth — basta usar o Dio compartilhado.
///
/// - Sem login: registra anonimamente (sem header Authorization).
/// - Com login: backend recebe o Bearer e associa o token ao user_id.
class DeviceTokenApiService {
  DeviceTokenApiService(this._dio);

  final Dio _dio;

  Future<void> register({
    required String token,
    required String platform,
  }) async {
    await _dio.post(
      '/device-tokens',
      data: {'token': token, 'platform': platform},
    );
  }
}
