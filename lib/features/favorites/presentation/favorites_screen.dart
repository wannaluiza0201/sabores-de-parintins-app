import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/data/providers/auth_providers.dart';
import '../../establishments/presentation/widgets/establishment_card.dart';
import '../data/providers/favorites_list_provider.dart';

/// Tela "Meus Favoritos". Acessada via `context.push('/favorites')`
/// — empilhada por cima do AppShell, com botão de back automático.
class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  // ScrollController detecta proximidade do fim da lista pra disparar
  // loadMore. Alternativa: NotificationListener<ScrollNotification>,
  // mas Controller é mais direto pra "calcular distância do fim".
  final _scroll = ScrollController();

  // Threshold em pixels — quando faltar menos que isso pro fim, carrega
  // a próxima página. 300px = ~1 card de antecedência.
  static const _loadMoreThreshold = 300.0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final remaining = _scroll.position.maxScrollExtent - _scroll.position.pixels;
    if (remaining < _loadMoreThreshold) {
      ref.read(favoritesListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Auto-pop ao detectar logout (ex: 401 expirou o token enquanto a
    // tela estava aberta). Sem isso, o user veria uma lista órfã que
    // ele não pode mais interagir.
    ref.listen<AuthState>(authStateProvider, (prev, next) {
      final wasAuth = prev?.status == AuthStatus.authenticated;
      final isAuth = next.status == AuthStatus.authenticated;
      if (wasAuth && !isAuth && context.mounted) {
        context.pop();
      }
    });

    final state = ref.watch(favoritesListProvider);

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          l10n.favoritesTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(favoritesListProvider.notifier).refresh(),
        child: _buildBody(state, l10n),
      ),
    );
  }

  Widget _buildBody(FavoritesListState state, AppLocalizations l10n) {
    // Primeira carga (sem itens ainda).
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Erro na primeira carga.
    if (state.error != null && state.items.isEmpty) {
      return _ErrorState(
        message: state.error!,
        onRetry: () => ref.read(favoritesListProvider.notifier).refresh(),
      );
    }

    // Lista vazia (sem favoritos).
    if (state.isEmpty) {
      return const _EmptyState();
    }

    // Lista com dados — itens + (opcional) spinner de loadMore no fim.
    return ListView.builder(
      controller: _scroll,
      // AlwaysScrollable garante que pull-to-refresh funciona mesmo
      // se a lista couber inteira na tela.
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }
        final item = state.items[index];
        return EstablishmentCard(item: item);
      },
    );
  }
}

// ============================================================
// Empty state
// ============================================================

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      // Pull-to-refresh funcionar mesmo no estado vazio.
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      children: [
        Icon(
          Icons.favorite_border,
          size: 96,
          color: AppColors.textSecondary.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.favoritesEmptyTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.favoritesEmptySubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// Error state
// ============================================================

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Pull-to-refresh disponível no erro também.
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      children: [
        Icon(
          Icons.wifi_off,
          size: 64,
          color: AppColors.textSecondary.withValues(alpha: 0.6),
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 20),
        Center(
          child: FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)!.commonRetry),
          ),
        ),
      ],
    );
  }
}
