import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/establishment_detail.dart';
import '../models/photo.dart';
import 'establishment_providers.dart';

part 'establishment_detail_provider.g.dart';

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
@riverpod
Future<EstablishmentDetail> establishmentDetail(Ref ref, String slug) {
  return ref
      .watch(establishmentRepositoryProvider)
      .fetchEstablishmentDetail(slug);
}

/// Galeria de fotos do estabelecimento. Endpoint separado do detail
/// pra permitir paginar/preguiçar no futuro.
@riverpod
Future<List<Photo>> establishmentPhotos(Ref ref, String slug) {
  return ref
      .watch(establishmentRepositoryProvider)
      .fetchEstablishmentPhotos(slug);
}
