import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../establishments/data/models/establishment.dart';
import '../repositories/favorites_repository.dart';
import 'favorites_provider.dart';

/// Estado da tela "Meus Favoritos". Modelo próprio (em vez de
/// `AsyncValue<List<Establishment>>`) porque precisamos distinguir
/// "carregando primeira página" de "carregando mais (já tem items)".
class FavoritesListState {
  const FavoritesListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 0,
    this.lastPage = 1,
    this.error,
  });

  final List<Establishment> items;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int lastPage;
  final String? error;

  bool get hasMore => currentPage < lastPage;
  bool get isEmpty => items.isEmpty && !isLoading && error == null;

  FavoritesListState copyWith({
    List<Establishment>? items,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? lastPage,
    String? error,
    bool clearError = false,
  }) {
    return FavoritesListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class FavoritesListNotifier extends Notifier<FavoritesListState> {
  @override
  FavoritesListState build() {
    // Carrega página 1 na primeira montagem da tela.
    Future.microtask(_loadFirst);

    // Sync com o Set global de favoritos:
    //   Se o user desfavoritar (do botão no card, do detail, ou da
    //   própria tela), o ID some do Set → removemos o card da lista
    //   local imediatamente. Sem isso, o coração viraria cinza mas o
    //   card continuaria na lista até o próximo refresh.
    ref.listen<Set<int>>(favoritesProvider, (prev, next) {
      if (prev == null) return;
      final removed = prev.difference(next);
      if (removed.isEmpty) return;
      state = state.copyWith(
        items: state.items
            .where((e) => !removed.contains(e.id))
            .toList(growable: false),
      );
    });

    return const FavoritesListState(isLoading: true);
  }

  /// Pull-to-refresh: reseta e busca página 1 de novo.
  Future<void> refresh() => _loadFirst();

  /// Chamado pelo scroll listener quando perto do fim da lista.
  /// Idempotente — chamadas duplicadas durante a request não duplicam.
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final repo = ref.read(favoritesRepositoryProvider);
      final res = await repo.getFavorites(page: state.currentPage + 1);
      state = state.copyWith(
        items: [...state.items, ...res.data],
        currentPage: res.currentPage,
        lastPage: res.lastPage,
        isLoadingMore: false,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingMore: false,
        error: 'Erro ao carregar mais favoritos.',
      );
    }
  }

  Future<void> _loadFirst() async {
    state = const FavoritesListState(isLoading: true);
    try {
      final repo = ref.read(favoritesRepositoryProvider);
      final res = await repo.getFavorites(page: 1);
      state = FavoritesListState(
        items: res.data,
        currentPage: res.currentPage,
        lastPage: res.lastPage,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Não foi possível carregar seus favoritos.',
      );
    }
  }
}

final favoritesListProvider =
    NotifierProvider<FavoritesListNotifier, FavoritesListState>(
      FavoritesListNotifier.new,
    );
