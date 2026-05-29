import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/review.dart';
import '../repositories/reviews_repository.dart';

part 'establishment_reviews_provider.g.dart';

/// Estado da lista de reviews de UM estabelecimento. Mesma forma do
/// `FavoritesListState` — tem `isLoading` (primeira carga) separado
/// de `isLoadingMore` (paginação).
class EstablishmentReviewsState {
  const EstablishmentReviewsState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 0,
    this.lastPage = 1,
    this.error,
  });

  final List<Review> items;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int lastPage;
  final String? error;

  bool get hasMore => currentPage < lastPage;
  bool get isEmpty => items.isEmpty && !isLoading && error == null;

  EstablishmentReviewsState copyWith({
    List<Review>? items,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? lastPage,
    String? error,
    bool clearError = false,
  }) {
    return EstablishmentReviewsState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Notifier por slug — uma instância por estabelecimento. O
/// `@riverpod` gera automaticamente um "family" (parametrizado por
/// slug) quando o `build()` recebe argumentos além do Notifier.
///
/// CONSUMO: `ref.watch(establishmentReviewsProvider(slug))`.
@riverpod
class EstablishmentReviews extends _$EstablishmentReviews {
  @override
  EstablishmentReviewsState build(String slug) {
    Future.microtask(_loadFirst);
    return const EstablishmentReviewsState(isLoading: true);
  }

  String get _slug => slug;

  Future<void> refresh() => _loadFirst();

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      final res = await repo.getEstablishmentReviews(
        _slug,
        page: state.currentPage + 1,
      );
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
        error: 'Erro ao carregar mais avaliações.',
      );
    }
  }

  Future<void> _loadFirst() async {
    state = const EstablishmentReviewsState(isLoading: true);
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      final res = await repo.getEstablishmentReviews(_slug, page: 1);
      state = EstablishmentReviewsState(
        items: res.data,
        currentPage: res.currentPage,
        lastPage: res.lastPage,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Não foi possível carregar as avaliações.',
      );
    }
  }
}
