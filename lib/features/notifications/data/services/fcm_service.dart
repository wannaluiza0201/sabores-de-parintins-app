import 'package:firebase_messaging/firebase_messaging.dart';

/// Wrapper fino sobre `FirebaseMessaging.instance` — só expõe o que o
/// repository/notifier de cima precisa.
///
/// Mantemos esta camada pra que o resto do app NÃO importe
/// `firebase_messaging` direto: facilita trocar/mockar em testes e
/// concentra as quirks da API (Stream estática vs instância, etc.).
class FcmService {
  FcmService(this._messaging);

  final FirebaseMessaging _messaging;

  /// Solicita permissão de notificação ao usuário.
  ///
  /// Comportamento por plataforma:
  /// - **iOS**: mostra o sheet nativo (Allow / Don't Allow).
  /// - **Android 13+** (API 33): mostra o prompt de `POST_NOTIFICATIONS`.
  /// - **Android <13**: retorna `authorized` sem prompt (permissão
  ///   implícita pela instalação do app).
  ///
  /// Retorna `true` se ficou em `authorized` ou `provisional` (iOS).
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// iOS-only: quando o app está em foreground, fazer o sistema desenhar
  /// o banner nativo (caso contrário, ele entrega só pro `onMessage` e
  /// nada aparece na tela). No Android isso é controlado por nós via
  /// `flutter_local_notifications` — esta config NÃO tem efeito lá.
  Future<void> setForegroundOptionsIos() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Token único do dispositivo na rede do FCM. Pode mudar (uninstall,
  /// reset de dados, etc.) — sempre escute `onTokenRefresh` também.
  Future<String?> getToken() => _messaging.getToken();

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  /// Inscreve o dispositivo em um tópico FCM. Permite mandar pushes em
  /// massa pelo backend (sem precisar listar tokens individuais).
  Future<void> subscribeToTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  /// Mensagens recebidas com app em **foreground**. O FCM NÃO desenha
  /// banner nesse estado — quem renderiza é o nosso código.
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  /// Toque do usuário na notificação quando o app estava em
  /// **background** (minimizado mas vivo).
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  /// Mensagem que **abriu** o app a partir do estado **terminated**.
  /// Retorna apenas UMA vez por cold-start; chamadas seguintes retornam
  /// `null`. Por isso é importante invocar logo no boot.
  Future<RemoteMessage?> getInitialMessage() => _messaging.getInitialMessage();
}
