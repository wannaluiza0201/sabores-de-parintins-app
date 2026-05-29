import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../establishments/data/providers/establishment_detail_provider.dart';
import '../data/providers/establishment_reviews_provider.dart';
import 'widgets/report_review_dialog.dart';
import 'widgets/review_card.dart';

/// Tela "Todas as avaliações" — paginação infinita, reusa `ReviewCard`.
///
/// `initialName` vem via `state.extra` do go_router quando a tela é
/// aberta a partir da detail (UX mais rápida — já temos o nome). Se
/// for null (deep link direto na rota, hipotético), cai no
/// `establishmentDetailProvider` pra resolver.
class AllReviewsScreen extends ConsumerStatefulWidget {
  const AllReviewsScreen({super.key, required this.slug, this.initialName});

  final String slug;
  final String? initialName;

  @override
  ConsumerState<AllReviewsScreen> createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends ConsumerState<AllReviewsScreen> {
  final _scroll = ScrollController();
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
    final remaining =
        _scroll.position.maxScrollExtent - _scroll.position.pixels;
    if (remaining < _loadMoreThreshold) {
      ref
          .read(establishmentReviewsProvider(widget.slug).notifier)
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(establishmentReviewsProvider(widget.slug));
    // Fallback do nome: extra primeiro, depois cache do detail provider.
    final detailName =
        ref.watch(establishmentDetailProvider(widget.slug)).value?.name;
    final name = widget.initialName ?? detailName;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        // Column como title permite "linha 1 + linha 2 menor" — não
        // existe `subtitle` nativo no AppBar.
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.reviewsSectionTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (name != null && name.isNotEmpty)
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(establishmentReviewsProvider(widget.slug).notifier)
            .refresh(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(EstablishmentReviewsState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.items.isEmpty) {
      return _ErrorState(
        message: state.error!,
        onRetry: () => ref
            .read(establishmentReviewsProvider(widget.slug).notifier)
            .refresh(),
      );
    }

    if (state.isEmpty) {
      return const _EmptyState();
    }

    return ListView.builder(
      controller: _scroll,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }
        final review = state.items[index];
        return ReviewCard(
          review: review,
          // Listagem pública mostra só visible — não há "Editar" aqui;
          // edição é só pela detail. Sempre "..." (denunciar).
          isMine: false,
          onReport: () =>
              ReportReviewDialog.show(context, reviewId: review.id),
        );
      },
    );
  }
}

// ============================================================
// Estados auxiliares
// ============================================================

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      children: [
        Icon(
          Icons.rate_review_outlined,
          size: 96,
          color: AppColors.textSecondary.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.reviewsEmptyTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.reviewsListEmptySubtitle,
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

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
