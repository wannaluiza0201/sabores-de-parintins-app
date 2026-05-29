// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Singleton do repository, injetando o Dio compartilhado.

@ProviderFor(establishmentRepository)
final establishmentRepositoryProvider = EstablishmentRepositoryProvider._();

/// Singleton do repository, injetando o Dio compartilhado.

final class EstablishmentRepositoryProvider
    extends
        $FunctionalProvider<
          EstablishmentRepository,
          EstablishmentRepository,
          EstablishmentRepository
        >
    with $Provider<EstablishmentRepository> {
  /// Singleton do repository, injetando o Dio compartilhado.
  EstablishmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'establishmentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$establishmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<EstablishmentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EstablishmentRepository create(Ref ref) {
    return establishmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EstablishmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EstablishmentRepository>(value),
    );
  }
}

String _$establishmentRepositoryHash() =>
    r'db306db2aecd710629d0ba47a93853cb365d140e';

/// Lista de estabelecimentos pra Home (sem filtros).
/// Consumir com `ref.watch(establishmentsProvider)` → `AsyncValue<List<…>>`.

@ProviderFor(establishments)
final establishmentsProvider = EstablishmentsProvider._();

/// Lista de estabelecimentos pra Home (sem filtros).
/// Consumir com `ref.watch(establishmentsProvider)` → `AsyncValue<List<…>>`.

final class EstablishmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Establishment>>,
          List<Establishment>,
          FutureOr<List<Establishment>>
        >
    with
        $FutureModifier<List<Establishment>>,
        $FutureProvider<List<Establishment>> {
  /// Lista de estabelecimentos pra Home (sem filtros).
  /// Consumir com `ref.watch(establishmentsProvider)` → `AsyncValue<List<…>>`.
  EstablishmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'establishmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$establishmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<Establishment>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Establishment>> create(Ref ref) {
    return establishments(ref);
  }
}

String _$establishmentsHash() => r'9649c2d61e0099d50aa144ae373a861cedc72e3b';

/// Todas as categorias (com `establishments_count`) pro carousel da Home.

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

/// Todas as categorias (com `establishments_count`) pro carousel da Home.

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Category>>,
          List<Category>,
          FutureOr<List<Category>>
        >
    with $FutureModifier<List<Category>>, $FutureProvider<List<Category>> {
  /// Todas as categorias (com `establishments_count`) pro carousel da Home.
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Category>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Category>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'80a2f2a10533f84a26e03ecd9aae540696f73c24';
