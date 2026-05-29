import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../models/category.dart';
import '../models/establishment.dart';
import '../repositories/establishment_repository.dart';

part 'establishment_providers.g.dart';

/// Singleton do repository, injetando o Dio compartilhado.
@Riverpod(keepAlive: true)
EstablishmentRepository establishmentRepository(Ref ref) {
  return EstablishmentRepository(ref.watch(dioProvider));
}

/// Lista de estabelecimentos pra Home (sem filtros).
/// Consumir com `ref.watch(establishmentsProvider)` → `AsyncValue<List<…>>`.
@riverpod
Future<List<Establishment>> establishments(Ref ref) {
  return ref.watch(establishmentRepositoryProvider).fetchEstablishments();
}

/// Todas as categorias (com `establishments_count`) pro carousel da Home.
@riverpod
Future<List<Category>> categories(Ref ref) {
  return ref.watch(establishmentRepositoryProvider).fetchCategories();
}
