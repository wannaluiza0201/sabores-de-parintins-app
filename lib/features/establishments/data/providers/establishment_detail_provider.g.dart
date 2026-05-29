// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Detalhe completo de um estabelecimento por slug.
///
/// Como o builder recebe um parâmetro além do `Ref`, o `riverpod_generator`
/// produz automaticamente um "family" — i.e. um provider parametrizado.
/// No widget você consome com:
///
///   ref.watch(establishmentDetailProvider(slug))
///
/// Cada slug tem seu próprio cache (e seu próprio AsyncValue). Riverpod
/// só refetcha quando o slug muda ou quando alguém invalida.

@ProviderFor(establishmentDetail)
final establishmentDetailProvider = EstablishmentDetailFamily._();

/// Detalhe completo de um estabelecimento por slug.
///
/// Como o builder recebe um parâmetro além do `Ref`, o `riverpod_generator`
/// produz automaticamente um "family" — i.e. um provider parametrizado.
/// No widget você consome com:
///
///   ref.watch(establishmentDetailProvider(slug))
///
/// Cada slug tem seu próprio cache (e seu próprio AsyncValue). Riverpod
/// só refetcha quando o slug muda ou quando alguém invalida.

final class EstablishmentDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<EstablishmentDetail>,
          EstablishmentDetail,
          FutureOr<EstablishmentDetail>
        >
    with
        $FutureModifier<EstablishmentDetail>,
        $FutureProvider<EstablishmentDetail> {
  /// Detalhe completo de um estabelecimento por slug.
  ///
  /// Como o builder recebe um parâmetro além do `Ref`, o `riverpod_generator`
  /// produz automaticamente um "family" — i.e. um provider parametrizado.
  /// No widget você consome com:
  ///
  ///   ref.watch(establishmentDetailProvider(slug))
  ///
  /// Cada slug tem seu próprio cache (e seu próprio AsyncValue). Riverpod
  /// só refetcha quando o slug muda ou quando alguém invalida.
  EstablishmentDetailProvider._({
    required EstablishmentDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'establishmentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$establishmentDetailHash();

  @override
  String toString() {
    return r'establishmentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EstablishmentDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EstablishmentDetail> create(Ref ref) {
    final argument = this.argument as String;
    return establishmentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EstablishmentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$establishmentDetailHash() =>
    r'729796778fa0c22f751f37b51eedc3190edd0b62';

/// Detalhe completo de um estabelecimento por slug.
///
/// Como o builder recebe um parâmetro além do `Ref`, o `riverpod_generator`
/// produz automaticamente um "family" — i.e. um provider parametrizado.
/// No widget você consome com:
///
///   ref.watch(establishmentDetailProvider(slug))
///
/// Cada slug tem seu próprio cache (e seu próprio AsyncValue). Riverpod
/// só refetcha quando o slug muda ou quando alguém invalida.

final class EstablishmentDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EstablishmentDetail>, String> {
  EstablishmentDetailFamily._()
    : super(
        retry: null,
        name: r'establishmentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Detalhe completo de um estabelecimento por slug.
  ///
  /// Como o builder recebe um parâmetro além do `Ref`, o `riverpod_generator`
  /// produz automaticamente um "family" — i.e. um provider parametrizado.
  /// No widget você consome com:
  ///
  ///   ref.watch(establishmentDetailProvider(slug))
  ///
  /// Cada slug tem seu próprio cache (e seu próprio AsyncValue). Riverpod
  /// só refetcha quando o slug muda ou quando alguém invalida.

  EstablishmentDetailProvider call(String slug) =>
      EstablishmentDetailProvider._(argument: slug, from: this);

  @override
  String toString() => r'establishmentDetailProvider';
}

/// Galeria de fotos do estabelecimento. Endpoint separado do detail
/// pra permitir paginar/preguiçar no futuro.

@ProviderFor(establishmentPhotos)
final establishmentPhotosProvider = EstablishmentPhotosFamily._();

/// Galeria de fotos do estabelecimento. Endpoint separado do detail
/// pra permitir paginar/preguiçar no futuro.

final class EstablishmentPhotosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Photo>>,
          List<Photo>,
          FutureOr<List<Photo>>
        >
    with $FutureModifier<List<Photo>>, $FutureProvider<List<Photo>> {
  /// Galeria de fotos do estabelecimento. Endpoint separado do detail
  /// pra permitir paginar/preguiçar no futuro.
  EstablishmentPhotosProvider._({
    required EstablishmentPhotosFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'establishmentPhotosProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$establishmentPhotosHash();

  @override
  String toString() {
    return r'establishmentPhotosProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Photo>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Photo>> create(Ref ref) {
    final argument = this.argument as String;
    return establishmentPhotos(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EstablishmentPhotosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$establishmentPhotosHash() =>
    r'59c81eea8fe2dda742ec5f3f21eac65c48f030e3';

/// Galeria de fotos do estabelecimento. Endpoint separado do detail
/// pra permitir paginar/preguiçar no futuro.

final class EstablishmentPhotosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Photo>>, String> {
  EstablishmentPhotosFamily._()
    : super(
        retry: null,
        name: r'establishmentPhotosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Galeria de fotos do estabelecimento. Endpoint separado do detail
  /// pra permitir paginar/preguiçar no futuro.

  EstablishmentPhotosProvider call(String slug) =>
      EstablishmentPhotosProvider._(argument: slug, from: this);

  @override
  String toString() => r'establishmentPhotosProvider';
}
