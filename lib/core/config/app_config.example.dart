/// Template do AppConfig — este arquivo É commitado.
///
/// Pra rodar o app: copie pra `app_config.dart` (gitignored) e
/// preencha com os valores do seu ambiente.
class AppConfig {
  /// Web OAuth Client ID — criar no Google Cloud Console como
  /// "Application type: Web application". Cole aqui o ID completo
  /// terminando em `.apps.googleusercontent.com`.
  static const String googleWebClientId =
      'PASTE_YOUR_WEB_CLIENT_ID.apps.googleusercontent.com';

  /// Base da API REST do backend Laravel.
  /// - Emulador Android: `http://10.0.2.2/api/v1`
  /// - Device físico: `http://<IP-DA-MAQUINA>/api/v1`
  /// - Produção: URL real
  static const String apiBaseUrl = 'http://10.0.2.2/api/v1';
}
