import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/config/app_config.dart';

/// Wrapper fino sobre o SDK do Google Sign-In.
///
/// CONCEITO: `serverClientId` é o **Web** Client ID (não o Android).
/// Isso instrui o Google a emitir um `id_token` cuja audience é o
/// backend identificado pelo Web Client ID — daí o backend consegue
/// validar a assinatura quando recebe o token.
class GoogleSignInService {
  GoogleSignInService()
      : _googleSignIn = GoogleSignIn(
          serverClientId: AppConfig.googleWebClientId,
          scopes: const ['email', 'profile'],
        );

  final GoogleSignIn _googleSignIn;

  /// Abre a tela nativa do Google. Retorna `null` se o usuário
  /// cancelar; senão retorna o `id_token` pronto pra enviar ao backend.
  ///
  /// Lança exception em casos de erro (sem rede, sem Play Services,
  /// conta corporativa restrita, etc.). O repository decide o que fazer.
  Future<String?> signInAndGetIdToken() async {
    // signIn() retorna null se o usuário fechar/cancelar o sheet.
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    final auth = await account.authentication;
    return auth.idToken;
  }

  /// Desloga do Google **no nível do dispositivo** — diferente do
  /// `/auth/logout` da nossa API, que invalida o Sanctum token.
  ///
  /// Sem isso, o próximo `signIn()` reusa a conta já vinculada e o
  /// usuário não vê o seletor de conta novamente.
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      // Best-effort: se falhar (raríssimo), não bloqueia o logout do app.
    }
  }
}
