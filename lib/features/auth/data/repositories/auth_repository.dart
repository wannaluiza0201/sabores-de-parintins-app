import 'package:dio/dio.dart';

import '../models/auth_user.dart';
import '../services/auth_api_service.dart';
import '../services/google_sign_in_service.dart';
import '../services/secure_storage_service.dart';

/// Lançada quando o usuário **fecha/cancela** o sheet do Google.
/// Não é erro — a UI deve ignorar silenciosamente.
class AuthCancelledException implements Exception {
  const AuthCancelledException();
  @override
  String toString() => 'AuthCancelledException';
}

/// Orquestra os 3 services: Google → API → Storage.
///
/// É a única classe que a UI/providers tocam. Mantém a regra de "uma
/// camada toca a próxima, nunca pula" — UI fala com Repository,
/// Repository fala com Services.
class AuthRepository {
  AuthRepository({
    required GoogleSignInService google,
    required AuthApiService api,
    required SecureStorageService storage,
  })  : _google = google,
        _api = api,
        _storage = storage;

  final GoogleSignInService _google;
  final AuthApiService _api;
  final SecureStorageService _storage;

  /// Fluxo completo: abre Google → troca por Sanctum token → salva.
  ///
  /// Throws:
  /// - `AuthCancelledException` se o usuário fechou o sheet
  /// - `DioException` em falha de rede/HTTP (UI mostra SnackBar genérico)
  /// - exception do Google SDK (sem Play Services, etc.)
  Future<AuthUser> signInWithGoogle() async {
    final idToken = await _google.signInAndGetIdToken();
    if (idToken == null) {
      throw const AuthCancelledException();
    }

    final response = await _api.postGoogleSignIn(idToken);
    await _storage.saveToken(response.token);
    await _storage.saveUser(response.user);
    return response.user;
  }

  /// Logout em 3 frentes, com tolerância a falhas parciais:
  /// 1. API (revoga token) — best-effort, se cair sem internet OK
  /// 2. Google SDK (desvincula a conta) — pra mostrar seletor de novo
  /// 3. SecureStorage (apaga local) — esse é o crítico, sempre roda
  Future<void> signOut() async {
    try {
      await _api.postLogout();
    } on DioException {
      // Sem internet ou backend caiu — o token vai expirar em breve
      // mesmo. Limpa local de qualquer jeito.
    }
    await _google.signOut();
    await _storage.clear();
  }

  /// Chamado no boot: se há token salvo, valida com `/me`.
  ///
  /// Retornos:
  /// - `null` se nunca logou OU se o token salvo é inválido (401)
  /// - `AuthUser` atualizado (com nome/avatar frescos do backend)
  ///
  /// O 401 é tratado aqui (não no AuthInterceptor) porque queremos
  /// LIMPAR o storage silenciosamente — o interceptor é pra requests
  /// "ativos" do usuário, onde o 401 dispara o estado unauthenticated.
  Future<AuthUser?> restoreSession() async {
    final token = await _storage.readToken();
    if (token == null || token.isEmpty) return null;

    try {
      final user = await _api.getMe();
      // Atualiza cache local com a versão fresca do backend.
      await _storage.saveUser(user);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expirado/revogado. Limpa e fica como deslogado.
        await _storage.clear();
        return null;
      }
      // Outros erros (sem internet, etc.): mantém o token, retorna o
      // user do cache local pra UX otimista. Próximo /me reanima.
      return await _storage.readUser();
    }
  }
}
