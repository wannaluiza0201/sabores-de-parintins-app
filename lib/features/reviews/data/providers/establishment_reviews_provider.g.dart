// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_reviews_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier por slug — uma instância por estabelecimento. O
/// `@riverpod` gera automaticamente um "family" (parametrizado por
/// slug) quando o `build()` recebe argumentos além do Notifier.
///
/// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.

@ProviderFor(EstablishmentReviews)
final establishmentReviewsProvider = EstablishmentReviewsFamily._();

/// Notifier por slug — uma instância por estabelecimento. O
/// `@riverpod` gera automaticamente um "family" (parametrizado por
/// slug) quando o `build()` recebe argumentos além do Notifier.
///
/// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.
final class EstablishmentReviewsProvider
    extends $NotifierProvider<EstablishmentReviews, EstablishmentReviewsState> {
  /// Notifier por slug — uma instância por estabelecimento. O
  /// `@riverpod` gera automaticamente um "family" (parametrizado por
  /// slug) quando o `build()` recebe argumentos além do Notifier.
  ///
  /// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.
  EstablishmentReviewsProvider._({
    required EstablishmentReviewsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'establishmentReviewsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$establishmentReviewsHash();

  @override
  String toString() {
    return r'establishmentReviewsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EstablishmentReviews create() => EstablishmentReviews();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EstablishmentReviewsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EstablishmentReviewsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EstablishmentReviewsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$establishmentReviewsHash() =>
    r'004ee2420c0bb2b7c7cb4a371c9011804dcaf62c';

/// Notifier por slug — uma instância por estabelecimento. O
/// `@riverpod` gera automaticamente um "family" (parametrizado por
/// slug) quando o `build()` recebe argumentos além do Notifier.
///
/// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.

final class EstablishmentReviewsFamily extends $Family
    with
        $ClassFamilyOverride<
          EstablishmentReviews,
          EstablishmentReviewsState,
          EstablishmentReviewsState,
          EstablishmentReviewsState,
          String
        > {
  EstablishmentReviewsFamily._()
    : super(
        retry: null,
        name: r'establishmentReviewsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier por slug — uma instância por estabelecimento. O
  /// `@riverpod` gera automaticamente um "family" (parametrizado por
  /// slug) quando o `build()` recebe argumentos além do Notifier.
  ///
  /// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.

  EstablishmentReviewsProvider call(String slug) =>
      EstablishmentReviewsProvider._(argument: slug, from: this);

  @override
  String toString() => r'establishmentReviewsProvider';
}

/// Notifier por slug — uma instância por estabelecimento. O
/// `@riverpod` gera automaticamente um "family" (parametrizado por
/// slug) quando o `build()` recebe argumentos além do Notifier.
///
/// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.

abstract class _$EstablishmentReviews
    extends $Notifier<EstablishmentReviewsState> {
  late final _$args = ref.$arg as String;
  String get slug => _$args;

  EstablishmentReviewsState build(String slug);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<EstablishmentReviewsState, EstablishmentReviewsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EstablishmentReviewsState, EstablishmentReviewsState>,
              EstablishmentReviewsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
