import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/providers/auth_providers.dart';
import 'features/notifications/data/providers/notifications_providers.dart';
import 'features/settings/data/providers/locale_providers.dart';
import 'l10n/gen/app_localizations.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    // Restaura sessão (token salvo → /me → estado autenticado) uma
    // ÚNICA vez no boot. Usa Future.microtask porque ref.read em
    // initState exige adiar o trabalho pra próxima microtask.
    Future.microtask(() {
      ref.read(authStateProvider.notifier).restore();
      // Boot do FCM: permissão, tópico "todos", token+register,
      // listeners de mensagens. Idempotente — chamadas extras são no-op.
      ref.read(notificationsControllerProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    // `locale` null → MaterialApp escolhe automaticamente entre
    // supportedLocales olhando o do sistema. Preferência do usuário
    // override esse comportamento (rebuilds quando o provider muda).
    final locale = ref.watch(localeControllerProvider);

    // MaterialApp.router conecta o go_router ao Navigator do Material.
    return MaterialApp.router(
      title: 'Sabores de Parintins',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
      // i18n — delegates do Material/Cupertino/Widgets vêm junto via
      // AppLocalizations.localizationsDelegates (compõe os 4).
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
