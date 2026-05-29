// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localeStorageService)
final localeStorageServiceProvider = LocaleStorageServiceProvider._();

final class LocaleStorageServiceProvider
    extends
        $FunctionalProvider<
          LocaleStorageService,
          LocaleStorageService,
          LocaleStorageService
        >
    with $Provider<LocaleStorageService> {
  LocaleStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeStorageServiceHash();

  @$internal
  @override
  $ProviderElement<LocaleStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocaleStorageService create(Ref ref) {
    return localeStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaleStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaleStorageService>(value),
    );
  }
}

String _$localeStorageServiceHash() =>
    r'2ae58fc49f9ac8fb64721d8aab073187ab433f35';

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

@ProviderFor(LocaleController)
final localeControllerProvider = LocaleControllerProvider._();

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
final class LocaleControllerProvider
    extends $NotifierProvider<LocaleController, Locale?> {
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
  LocaleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeControllerHash();

  @$internal
  @override
  LocaleController create() => LocaleController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$localeControllerHash() => r'5baa9f7aacbee01054ccce935bd346b90b2d7dae';

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

abstract class _$LocaleController extends $Notifier<Locale?> {
  Locale? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale?, Locale?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale?, Locale?>,
              Locale?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
