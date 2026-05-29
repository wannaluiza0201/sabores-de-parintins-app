import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/review.dart';
import '../repositories/reviews_repository.dart';

/// Estado da tela "Minhas Avaliações". Mesma forma do
/// `EstablishmentReviewsState`. Cada item tem `establishment` embedded.
class MyReviewsState {
  const MyReviewsState({
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

  MyReviewsState copyWith({
    List<Review>? items,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? lastPage,
    String? error,
    bool clearError = false,
  }) {
    return MyReviewsState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class MyReviewsNotifier extends Notifier<MyReviewsState> {
  @override
  MyReviewsState build() {
    Future.microtask(_loadFirst);
    return const MyReviewsState(isLoading: true);
  }

  Future<void> refresh() => _loadFirst();

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      final res = await repo.getMyReviews(page: state.currentPage + 1);
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

  /// Remoção local imediata após DELETE bem-sucedido (sem refetch).
  /// Usado pelo Dismissible da tela "Minhas Avaliações" pra animar
  /// o card saindo da lista.
  void removeLocally(int reviewId) {
    state = state.copyWith(
      items: state.items.where((r) => r.id != reviewId).toList(growable: false),
    );
  }

  Future<void> _loadFirst() async {
    state = const MyReviewsState(isLoading: true);
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      final res = await repo.getMyReviews(page: 1);
      state = MyReviewsState(
        items: res.data,
        currentPage: res.currentPage,
        lastPage: res.lastPage,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Não foi possível carregar suas avaliações.',
      );
    }
  }
}

final myReviewsProvider = NotifierProvider<MyReviewsNotifier, MyReviewsState>(
  MyReviewsNotifier.new,
);
