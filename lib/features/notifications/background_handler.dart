import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

/// Handler de mensagens FCM recebidas com app em **background ou
/// terminated**.
///
/// CONCEITOS:
/// - O Android acorda o app em um **isolate Dart separado** pra rodar
///   este handler. Esse isolate NÃO tem Flutter, NÃO tem widgets, NÃO
///   tem o `Firebase.initializeApp` que você rodou no `main()` (cada
///   isolate tem sua própria memória). Por isso reinicializamos aqui.
/// - `@pragma('vm:entry-point')` impede o tree-shaker de apagar esta
///   função. Como o "chamador" é nativo (Java/Kotlin), o compilador
///   Dart acha que ninguém usa e tentaria remover.
/// - Deve ser **top-level** ou **static** — não pode ser método de
///   instância, porque o isolate não tem acesso ao seu objeto.
///
/// IMPORTANTE: aqui NÃO desenhamos notificação manualmente. Quando a
/// mensagem tem o campo `notification` (caso padrão do backend), o
/// próprio sistema Android desenha o banner na bandeja. O toque dispara
/// `getInitialMessage` (terminated) ou `onMessageOpenedApp` (background)
/// no isolate principal — é lá que o `NotificationsController` navega.
@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint(
    '[FCM bg] data=${message.data} notif=${message.notification?.title}',
  );
}
