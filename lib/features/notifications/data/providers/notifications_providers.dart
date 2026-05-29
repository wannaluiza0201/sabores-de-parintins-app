import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/data/providers/auth_providers.dart';
import '../models/push_payload.dart';
import '../repositories/notifications_repository.dart';
import '../services/device_token_api_service.dart';
import '../services/fcm_service.dart';
import '../services/local_notifications_service.dart';

part 'notifications_providers.g.dart';

// ============================================================
// Singletons dos services + repository.
// keepAlive: true porque devem viver pela sessão inteira do app
// (não faz sentido recriar — listeners do FCM são globais).
// ============================================================

@Riverpod(keepAlive: true)
FcmService fcmService(Ref ref) => FcmService(FirebaseMessaging.instance);

@Riverpod(keepAlive: true)
LocalNotificationsService localNotificationsService(Ref ref) =>
    LocalNotificationsService(FlutterLocalNotificationsPlugin());

@Riverpod(keepAlive: true)
DeviceTokenApiService deviceTokenApiService(Ref ref) =>
    DeviceTokenApiService(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(Ref ref) {
  return NotificationsRepository(
    fcm: ref.watch(fcmServiceProvider),
    local: ref.watch(localNotificationsServiceProvider),
    api: ref.watch(deviceTokenApiServiceProvider),
  );
}

// ============================================================
// Controller — orquestração completa.
//
// CONCEITO — por que `Notifier<void>`:
// Este controller é **imperativo**: dispara init() no boot e reage a
// eventos (mensagens FCM, mudança de auth). Não tem "estado" pra UI
// observar — então `void` é honesto. Se a UI precisar saber "qtd de
// notificações não lidas" no futuro, troca `void` por uma classe
// `NotificationsState`.
// ============================================================

@Riverpod(keepAlive: true)
class NotificationsController extends _$NotificationsController {
  bool _initialized = false;

  @override
  void build() {
    // Re-registra o FCM token logo APÓS o login. Como o AuthInterceptor
    // já injeta Bearer automaticamente, basta reenviar — o backend
    // associa o token ao user_id pela presença do header.
    //
    // Captura também o caso "já estava logado ao abrir o app":
    // estado inicial é `initial`, o restoreSession transita pra
    // `authenticated`, e este listen dispara.
    ref.listen(authStateProvider, (prev, next) {
      final wasAuth = prev?.status == AuthStatus.authenticated;
      final isAuth = next.status == AuthStatus.authenticated;
      if (!wasAuth && isAuth) {
        _registerCurrentToken();
      }
    });
  }

  NotificationsRepository get _repo =>
      ref.read(notificationsRepositoryProvider);

  /// Chamado UMA VEZ no boot do app (do `App.initState`).
  /// Idempotente: chamadas adicionais são no-op.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    debugPrint('[FCM] init() iniciando...');

    // 1. Permissão — sheet nativo iOS / prompt POST_NOTIFICATIONS Android 13+.
    //    Não bloqueamos a UX: mesmo se o usuário negar, o registro de
    //    token segue (pode ser útil pro backend saber que o device
    //    existe; o backend não envia push se sabe que está negado).
    final granted = await _repo.requestPermission();
    debugPrint('[FCM] permissao concedida = $granted');

    // 2. iOS: faz o sistema desenhar banner mesmo com app em foreground.
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _repo.setIosForegroundPresentation();
    }

    // 3. flutter_local_notifications: cria channel Android + registra
    //    callback de toque (usado quando NÓS desenhamos a notificação
    //    em foreground no Android).
    await _repo.initLocal(onTap: _handleTap);
    debugPrint('[FCM] local notifications init OK (channel criado)');

    // 4. Streams do FCM — foreground render + toques em background.
    _bindMessageStreams();
    debugPrint('[FCM] streams onMessage/onMessageOpenedApp registrados');

    // 5. Tópico "todos" — funciona sem login.
    await _repo.subscribeToTopic('todos');
    debugPrint('[FCM] subscribe topic "todos" feito');

    // 6. Token inicial + registro no backend (anônimo se deslogado).
    final token = await _repo.getToken();
    debugPrint('[FCM] token = $token');
    if (token != null && token.isNotEmpty) {
      await _repo.registerToken(token);
      debugPrint('[FCM] token enviado pro backend');
    }

    // 7. Token pode rotacionar (uninstall, reset, etc.) — sempre
    //    re-registra quando muda.
    final refreshSub =
        _repo.onTokenRefresh.listen((t) => _repo.registerToken(t));
    ref.onDispose(refreshSub.cancel);

    // 8. Terminated → app aberto via toque na notificação.
    //    Adiamos pro próximo frame pra garantir que o GoRouter já
    //    montou (evita "tried to use GoRouter before it was built").
    final initial = await _repo.getInitialMessage();
    if (initial != null) {
      // Pequeno delay pra a UI estabilizar antes de empurrar a rota.
      Future.delayed(const Duration(milliseconds: 300), () {
        _navigate(PushPayload.fromData(initial.data));
      });
    }
  }

  // ============================================================
  // Listeners de mensagens
  // ============================================================

  void _bindMessageStreams() {
    final fgSub = FirebaseMessaging.onMessage.listen(_handleForeground);
    final openSub = FirebaseMessaging.onMessageOpenedApp
        .listen((m) => _navigate(PushPayload.fromData(m.data)));
    ref.onDispose(fgSub.cancel);
    ref.onDispose(openSub.cancel);
  }

  /// Foreground:
  /// - Android: FCM NÃO desenha — usamos flutter_local_notifications.
  /// - iOS: o sistema desenha (config feita no init), então pular aqui
  ///   evita duplicar a notificação.
  Future<void> _handleForeground(RemoteMessage message) async {
    debugPrint('[FCM] onMessage recebido — notif=${message.notification?.title} '
        'body=${message.notification?.body} data=${message.data}');
    if (defaultTargetPlatform == TargetPlatform.iOS) return;

    final notif = message.notification;
    if (notif == null) {
      debugPrint('[FCM] mensagem sem campo notification — '
          'ignorando render (provavelmente data-only message)');
      return;
    }

    await _repo.showLocal(
      title: notif.title ?? 'Sabores de Parintins',
      body: notif.body ?? '',
      // `message.data` é `Map<String, dynamic>` mas com valores quase
      // sempre String (limitação do FCM). Passamos cru — o decoder
      // do PushPayload tolera.
      data: Map<String, dynamic>.from(message.data),
    );
    debugPrint('[FCM] showLocal chamado');
  }

  /// Toque numa notificação que NÓS desenhamos (foreground/Android).
  void _handleTap(Map<String, dynamic> data) {
    _navigate(PushPayload.fromData(data));
  }

  // ============================================================
  // Registro pós-login (re-associar token ao user_id)
  // ============================================================

  Future<void> _registerCurrentToken() async {
    final token = await _repo.getToken();
    if (token == null || token.isEmpty) return;
    await _repo.registerToken(token);
  }

  // ============================================================
  // Navegação resiliente — usa o GoRouter exportado pelo módulo de
  // rotas. Se a rota não existir (ex.: backend manda um type novo
  // antes do app atualizar), cai pra home sem crashar.
  // ============================================================

  void _navigate(PushPayload payload) {
    try {
      switch (payload) {
        case PushPayloadEstablishment(:final slug):
          appRouter.push('/establishment/$slug');
        case PushPayloadHome():
          appRouter.go('/');
      }
    } catch (e) {
      debugPrint('[NotificationsController] navegação falhou: $e');
      // TODO: fallback definitivo quando houver tela de erro/onboarding
      //  específica. Por enquanto tenta a home; se nem isso funcionar,
      //  swallow — o app continua na tela atual.
      try {
        appRouter.go('/');
      } catch (_) {}
    }
  }
}
