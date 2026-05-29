import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'features/notifications/background_handler.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // ensureInitialized é obrigatório quando plugins nativos
  // (google_sign_in, flutter_secure_storage, geolocator, firebase_core)
  // podem rodar ANTES da primeira frame — caso típico do nosso
  // restoreSession, que dispara no initState do App.
  WidgetsFlutterBinding.ensureInitialized();

  // PASSO 13 — Firebase Cloud Messaging.
  // currentPlatform escolhe Android/iOS/Web em runtime e devolve o
  // FirebaseOptions correto. O arquivo firebase_options.dart é gerado
  // pelo `flutterfire configure` — se você está vendo erro de import
  // aqui, é porque o CLI ainda não foi rodado.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Registra o handler de mensagens em background/terminated. PRECISA
  // rodar antes do runApp e fora de qualquer classe (a função em si é
  // top-level, anotada com @pragma('vm:entry-point')).
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);

  runApp(const ProviderScope(child: App()));
}
