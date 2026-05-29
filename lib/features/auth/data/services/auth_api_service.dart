import 'package:dio/dio.dart';

import '../models/auth_user.dart';

/// Resposta de `POST /auth/google` — user + token Sanctum.
/// Usa record do Dart 3+ pra evitar criar uma classe só pra duas props.
typedef AuthLoginResponse = ({AuthUser user, String token});

/// Cliente HTTP fino pras 3 rotas de auth do backend Laravel.
///
/// Métodos lançam `DioException` em falhas de rede/HTTP. O repository
/// converte essas em exceptions tipadas que a UI consome.
class AuthApiService {
  AuthApiService(this._dio);

  final Dio _dio;

  /// Troca o `id_token` do Google por um Sanctum token nosso.
  /// O backend valida o token contra o Web Client ID configurado.
  Future<AuthLoginResponse> postGoogleSignIn(String idToken) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/google',
      data: {'id_token': idToken},
    );
    final data = response.data!;
    return (
      user: AuthUser.fromJson(data['user'] as Map<String, dynamic>),
      token: data['token'] as String,
    );
  }

  /// Pega o usuário atual a partir do token. Usado pra:
  /// - validar token salvo no boot (restoreSession)
  /// - sincronizar dados do user (nome/avatar mudaram no Google)
  ///
  /// O Authorization header vem do AuthInterceptor — não precisa
  /// montar manualmente aqui.
  Future<AuthUser> getMe() async {
    final response = await _dio.get<Map<String, dynamic>>('/me');
    final data = response.data!;
    // Algumas APIs retornam `{user: {...}}`, outras `{...}` direto.
    // Tolera ambos.
    final userJson = (data['user'] ?? data) as Map<String, dynamic>;
    return AuthUser.fromJson(userJson);
  }

  /// Revoga o token atual no backend (Sanctum).
  /// Best-effort: o repository ignora falha aqui (o usuário sai do app
  /// localmente mesmo se a request perder).
  Future<void> postLogout() async {
    await _dio.post('/auth/logout');
  }
}
