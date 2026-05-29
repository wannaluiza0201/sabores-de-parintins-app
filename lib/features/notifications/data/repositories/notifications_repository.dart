import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../services/device_token_api_service.dart';
import '../services/fcm_service.dart';
import '../services/local_notifications_service.dart';

/// Fachada sobre os 3 services. Mantém só **operações atômicas** —
/// orquestração (ordem dos passos, listeners, navegação) fica no
/// `NotificationsController`.
class NotificationsRepository {
  NotificationsRepository({
    required FcmService fcm,
    required LocalNotificationsService local,
    required DeviceTokenApiService api,
  })  : _fcm = fcm,
        _local = local,
        _api = api;

  final FcmService _fcm;
  final LocalNotificationsService _local;
  final DeviceTokenApiService _api;

  // ============================================================
  // Permissão / configuração de plataforma
  // ============================================================

  Future<bool> requestPermission() => _fcm.requestPermission();

  Future<void> setIosForegroundPresentation() =>
      _fcm.setForegroundOptionsIos();

  Future<void> initLocal({
    required void Function(Map<String, dynamic> data) onTap,
  }) =>
      _local.init(onTap: onTap);

  // ============================================================
  // Tópico — "todos" é inscrito mesmo sem login.
  // Best-effort: falha de rede / Play Services ausente não derruba o boot.
  // ============================================================

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
    } catch (e) {
      debugPrint('[NotificationsRepository] subscribeToTopic falhou: $e');
    }
  }

  // ============================================================
  // Token — get + register no backend.
  // ============================================================

  Future<String?> getToken() => _fcm.getToken();

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  /// Mensagem que abriu o app a partir do estado **terminated**.
  /// Retorna apenas UMA vez por cold-start.
  Future<RemoteMessage?> getInitialMessage() => _fcm.getInitialMessage();

  /// Envia o token pro backend. Best-effort: se o backend estiver fora
  /// ou sem rede, NÃO propaga exceção — o próximo `onTokenRefresh` ou
  /// re-trigger via login vai tentar de novo.
  Future<void> registerToken(String token) async {
    final platform = defaultTargetPlatform == TargetPlatform.iOS
        ? 'ios'
        : 'android';
    try {
      await _api.register(token: token, platform: platform);
    } on DioException catch (e) {
      debugPrint('[NotificationsRepository] registerToken falhou: '
          '${e.response?.statusCode} ${e.message}');
    }
  }

  // ============================================================
  // Render local (foreground / Android).
  // ============================================================

  Future<void> showLocal({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) =>
      _local.show(title: title, body: body, data: data);
}
