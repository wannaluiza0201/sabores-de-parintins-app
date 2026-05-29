import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../establishments/data/models/establishment.dart';
import '../../../establishments/data/providers/establishment_providers.dart';

/// Texto atual na barra de busca. Default = "".
/// Atualizado pelo _SearchBar com debounce de 300ms.
///
/// OBS: `StateProvider` foi removido no Riverpod 3 — o substituto
/// idiomático pra estado mutável simples é uma classe `Notifier<T>`
/// com um método setter.
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

/// Id da categoria selecionada. null = "Todos" (sem filtro).
class SelectedCategoryIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? id) => state = id;
}

final selectedCategoryIdProvider =
    NotifierProvider<SelectedCategoryIdNotifier, int?>(
      SelectedCategoryIdNotifier.new,
    );

/// Lista filtrada — derivada da resposta da API + filtros locais.
///
/// Riverpod resolve as dependências automaticamente: quando QUALQUER
/// um dos `ref.watch` abaixo muda (lista da API, query, categoria),
/// este builder roda de novo e os widgets que observam este provider
/// reconstroem.
///
/// PRECEDÊNCIA: busca tem prioridade. Se há texto, categoria é
/// IGNORADA (chip continua "selecionado" visualmente, só não filtra).
final filteredEstablishmentsProvider = Provider<List<Establishment>>((ref) {
  // .value em AsyncValue<T> retorna T? (Riverpod 3 unificou valueOrNull → value).
  final list = ref.watch(establishmentsProvider).value ?? const [];
  final query = ref.watch(searchQueryProvider).trim();
  final categoryId = ref.watch(selectedCategoryIdProvider);

  // Sem filtros → lista original (preserva ordem da API).
  if (query.isEmpty && categoryId == null) return list;

  // Normaliza UMA vez (fora do .where) pra não pagar custo por item.
  final needle = query.isEmpty ? '' : _normalize(query);

  // AND lógico: o item precisa passar nos filtros ATIVOS. Se algum
  // dos dois não está ativo, ignora aquele check.
  return list.where((e) {
    if (needle.isNotEmpty) {
      final matchesText =
          _normalize(e.name).contains(needle) ||
          _normalize(e.description ?? '').contains(needle);
      if (!matchesText) return false;
    }
    if (categoryId != null) {
      final matchesCategory =
          e.primaryCategory.id == categoryId ||
          e.categories.any((c) => c.id == categoryId);
      if (!matchesCategory) return false;
    }
    return true;
  }).toList(growable: false);
});

// Mapa manual de diacríticos PT-BR. Mais leve que adicionar pacote
// (ex.: `diacritic`). Cobre só o que o app vai encontrar.
const _diacritics = <String, String>{
  'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a',
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
  'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
  'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
  'ç': 'c', 'ñ': 'n',
};

/// "Açaí do Rio" → "acai do rio". Case-insensitive + sem acentos.
String _normalize(String s) {
  var r = s.toLowerCase();
  _diacritics.forEach((from, to) => r = r.replaceAll(from, to));
  return r;
}
