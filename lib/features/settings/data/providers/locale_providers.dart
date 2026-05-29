import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/locale_storage_service.dart';

part 'locale_providers.g.dart';

@Riverpod(keepAlive: true)
LocaleStorageService localeStorageService(Ref ref) => LocaleStorageService();

/// Estado do idioma escolhido pelo usuário.
///
/// CONCEITO:
/// - `null` = "padrão do sistema". O `MaterialApp` resolve pelo
///   `localeResolutionCallback` (escolhe entre `supportedLocales`
///   olhando o locale do device).
/// - `Locale('pt')` / `Locale('en')` / `Locale('es')` = override
///   explícito.
///
/// O build retorna `null` síncronamente (não dá pra `await` no build de
/// um Notifier comum) e dispara `_restore()` em microtask pra carregar
/// a preferência salva. UX: app abre 1 frame no padrão do sistema,
/// depois "salta" pro idioma salvo. Aceitável — quase imperceptível.
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale? build() {
    Future.microtask(_restore);
    return null;
  }

  Future<void> _restore() async {
    final code = await ref.read(localeStorageServiceProvider).read();
    if (code == null || code.isEmpty) return;
    state = Locale(code);
  }

  /// Troca o idioma. Passa `null` pra voltar ao padrão do sistema.
  Future<void> setLocale(Locale? locale) async {
    final svc = ref.read(localeStorageServiceProvider);
    if (locale == null) {
      await svc.clear();
    } else {
      await svc.save(locale.languageCode);
    }
    state = locale;
  }
}
