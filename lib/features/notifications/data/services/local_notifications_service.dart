import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Wrapper sobre `FlutterLocalNotificationsPlugin`.
///
/// Responsabilidades:
/// - Criar o `NotificationChannel` do Android (obrigatório em API 26+
///   pra exibir QUALQUER notificação local).
/// - Renderizar pushes que chegaram com app em foreground.
/// - Encaminhar o toque do usuário pro `onTap` injetado, com o `data`
///   original da push já decodificado.
///
/// iOS NÃO usa channels — toda a categorização vem da própria payload
/// e das categorias UNNotification que registramos via APNs (fora do
/// escopo desta etapa).
class LocalNotificationsService {
  LocalNotificationsService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  /// Channel padrão de pushes do Sabores. Caso a gente adicione canais
  /// extras no futuro (ex.: "promoções", "novidades"), basta criar
  /// mais constantes e novos canais — o usuário pode silenciar
  /// individualmente nas configurações do sistema.
  static const _channelId = 'sabores_default';
  static const _channelName = 'Notificações';
  static const _channelDescription =
      'Notificações gerais do Sabores de Parintins';

  /// Inicializa o plugin + cria o channel Android.
  ///
  /// [onTap] recebe o `Map<String,dynamic>` que veio no `data` da push
  /// (já desserializado). É invocado quando o usuário toca numa
  /// notificação que ESTA classe desenhou (foreground). Toques em
  /// notificações desenhadas pelo SO (background/terminated) vêm pelo
  /// FirebaseMessaging, não por aqui.
  Future<void> init({
    required void Function(Map<String, dynamic> data) onTap,
  }) async {
    // `@mipmap/ic_launcher` é o ícone padrão do app — funciona como
    // fallback. Pra ícone monocromático customizado da bandeja, criar
    // um drawable e referenciar aqui.
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // No iOS NÃO pedimos permissão por aqui: o `FcmService.requestPermission`
    // já cobre. Pedir 2x mostraria 2 prompts (ou ignoraria o segundo).
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (response) {
        final raw = response.payload;
        if (raw == null || raw.isEmpty) {
          onTap(const {});
          return;
        }
        onTap(_decode(raw));
      },
    );

    // Cria o channel Android. Idempotente — chamar de novo com os
    // mesmos parâmetros não duplica nem reseta a config do usuário.
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
      ),
    );
  }

  /// Desenha uma notificação local. Usado APENAS quando o app está em
  /// foreground no Android (no iOS o sistema desenha sozinho via
  /// `setForegroundNotificationPresentationOptions`).
  Future<void> show({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    await _plugin.show(
      // ID precisa ser int32; usar o timestamp truncado garante unicidade
      // sem colisão prática.
      DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(data),
    );
  }

  Map<String, dynamic> _decode(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      // Payload corrompido — trata como vazio.
    }
    return const {};
  }
}
