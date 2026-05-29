// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banners_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bannersCacheService)
final bannersCacheServiceProvider = BannersCacheServiceProvider._();

final class BannersCacheServiceProvider
    extends
        $FunctionalProvider<
          BannersCacheService,
          BannersCacheService,
          BannersCacheService
        >
    with $Provider<BannersCacheService> {
  BannersCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannersCacheServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannersCacheServiceHash();

  @$internal
  @override
  $ProviderElement<BannersCacheService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BannersCacheService create(Ref ref) {
    return bannersCacheService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BannersCacheService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BannersCacheService>(value),
    );
  }
}

String _$bannersCacheServiceHash() =>
    r'6e1c13f5477fe0532161f2716475528750d2c1aa';

@ProviderFor(bannersRepository)
final bannersRepositoryProvider = BannersRepositoryProvider._();

final class BannersRepositoryProvider
    extends
        $FunctionalProvider<
          BannersRepository,
          BannersRepository,
          BannersRepository
        >
    with $Provider<BannersRepository> {
  BannersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannersRepositoryHash();

  @$internal
  @override
  $ProviderElement<BannersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BannersRepository create(Ref ref) {
    return bannersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BannersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BannersRepository>(value),
    );
  }
}

String _$bannersRepositoryHash() => r'6747833bcd890e8f8b180b8a48de6af9901af209';

/// Lista de banners pra Home. AsyncValue na UI:
/// - loading/error → carrossel cai no PromoBanner (fallback).
/// - data vazia → idem.
/// - data populada → renderiza o carrossel.

@ProviderFor(banners)
final bannersProvider = BannersProvider._();

/// Lista de banners pra Home. AsyncValue na UI:
/// - loading/error → carrossel cai no PromoBanner (fallback).
/// - data vazia → idem.
/// - data populada → renderiza o carrossel.

final class BannersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BannerItem>>,
          List<BannerItem>,
          FutureOr<List<BannerItem>>
        >
    with $FutureModifier<List<BannerItem>>, $FutureProvider<List<BannerItem>> {
  /// Lista de banners pra Home. AsyncValue na UI:
  /// - loading/error → carrossel cai no PromoBanner (fallback).
  /// - data vazia → idem.
  /// - data populada → renderiza o carrossel.
  BannersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannersHash();

  @$internal
  @override
  $FutureProviderElement<List<BannerItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BannerItem>> create(Ref ref) {
    return banners(ref);
  }
}

String _$bannersHash() => r'560d2c0914cdc9e019d2a4c04fcca88f50bf6ab3';
