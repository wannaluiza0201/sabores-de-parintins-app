import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/data/providers/auth_providers.dart';
import '../data/models/review.dart';
import '../data/providers/my_reviews_provider.dart';
import '../data/providers/review_submission_provider.dart';
import 'widgets/review_form_sheet.dart';
import 'widgets/star_rating_display.dart';

/// Tela "Minhas Avaliações". Mostra TODAS as reviews do user
/// (qualquer status). Cada card mostra o **estabelecimento** (não o
/// user) no header, status badge se != visible, botões editar/excluir.
class MyReviewsScreen extends ConsumerStatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  ConsumerState<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends ConsumerState<MyReviewsScreen> {
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
      ref.read(myReviewsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Auto-pop ao detectar logout — coerente com FavoritesScreen.
    ref.listen<AuthState>(authStateProvider, (prev, next) {
      final wasAuth = prev?.status == AuthStatus.authenticated;
      final isAuth = next.status == AuthStatus.authenticated;
      if (wasAuth && !isAuth && context.mounted) {
        context.pop();
      }
    });

    final state = ref.watch(myReviewsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.myReviewsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(myReviewsProvider.notifier).refresh(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(MyReviewsState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null && state.items.isEmpty) {
      return _ErrorState(
        message: state.error!,
        onRetry: () => ref.read(myReviewsProvider.notifier).refresh(),
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
        return _MyReviewCard(review: state.items[index]);
      },
    );
  }
}

// ============================================================
// Card de review do user (variação com establishment no header)
// ============================================================

class _MyReviewCard extends ConsumerStatefulWidget {
  const _MyReviewCard({required this.review});
  final Review review;

  @override
  ConsumerState<_MyReviewCard> createState() => _MyReviewCardState();
}

class _MyReviewCardState extends ConsumerState<_MyReviewCard> {
  bool _removing = false;

  Future<void> _confirmAndDelete() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final dl = AppLocalizations.of(ctx)!;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(dl.reviewDeleteConfirmTitle),
          content: Text(dl.reviewDeleteConfirmBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(dl.commonCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              child: Text(dl.commonDelete),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;

    final r = widget.review;
    await ref.read(reviewSubmissionProvider.notifier).delete(
          reviewId: r.id,
          slug: r.establishment?.slug,
        );

    if (!mounted) return;
    final subState = ref.read(reviewSubmissionProvider);
    if (subState is ReviewSubmissionError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(subState.message ?? l10n.reviewDeleteError),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Sucesso: anima fade-out + colapsa altura, depois remove local.
    setState(() => _removing = true);
    final reduce = MediaQuery.disableAnimationsOf(context);
    await Future.delayed(
      reduce ? Duration.zero : const Duration(milliseconds: 300),
    );
    if (mounted) {
      ref.read(myReviewsProvider.notifier).removeLocally(r.id);
    }
  }

  void _openEditSheet() {
    final r = widget.review;
    final est = r.establishment;
    if (est == null) return;
    ReviewFormSheet.show(context, establishment: est, existingReview: r);
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    // AnimatedCrossFade interpola entre o conteúdo do card e um
    // SizedBox.shrink() — colapsa altura + cross-fade simultâneo.
    return AnimatedCrossFade(
      duration: reduce ? Duration.zero : const Duration(milliseconds: 280),
      sizeCurve: Curves.easeOut,
      crossFadeState: _removing
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: _cardContent(),
      secondChild: const SizedBox.shrink(),
    );
  }

  Widget _cardContent() {
    final r = widget.review;
    final est = r.establishment;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: r.status != ReviewStatus.visible
            ? Border.all(
                color: _statusColor(r.status).withValues(alpha: 0.4),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- Header: foto + nome do ESTABELECIMENTO --------
          if (est != null)
            Row(
              children: [
                _EstablishmentThumb(url: est.coverPhotoUrl),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        est.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        est.primaryCategory.name,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          // -------- Status badge + texto explicativo --------
          if (r.status != ReviewStatus.visible) ...[
            const SizedBox(height: 10),
            _StatusBanner(status: r.status),
          ],

          const SizedBox(height: 10),

          // -------- Estrelas + rating numérico --------
          Row(
            children: [
              StarRatingDisplay(rating: r.rating.toDouble(), size: 16),
              const SizedBox(width: 6),
              Text(
                '${r.rating}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          // -------- Comentário (se houver) --------
          if ((r.comment ?? '').isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              r.comment!,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
          ],

          const SizedBox(height: 10),

          // -------- Botões editar / excluir --------
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (est != null)
                TextButton.icon(
                  onPressed: _openEditSheet,
                  icon: const Icon(Icons.edit, size: 16),
                  label: Text(AppLocalizations.of(context)!.commonEdit),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    minimumSize: const Size(0, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              TextButton.icon(
                onPressed: _confirmAndDelete,
                icon: const Icon(Icons.delete_outline, size: 16),
                label: Text(AppLocalizations.of(context)!.commonDelete),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.danger,
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Status banner — badge colorida + texto explicativo
// ============================================================

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.status});
  final ReviewStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = _statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_statusIcon(status), color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _statusLabel(status, l10n),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _statusExplain(status, l10n),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _statusColor(ReviewStatus s) {
  switch (s) {
    case ReviewStatus.pending:
      return AppColors.primary;
    case ReviewStatus.hidden:
      return const Color(0xFF757575);
    case ReviewStatus.rejected:
      return AppColors.danger;
    case ReviewStatus.visible:
      return AppColors.success;
  }
}

IconData _statusIcon(ReviewStatus s) {
  switch (s) {
    case ReviewStatus.pending:
      return Icons.hourglass_bottom_rounded;
    case ReviewStatus.hidden:
      return Icons.visibility_off_outlined;
    case ReviewStatus.rejected:
      return Icons.cancel_outlined;
    case ReviewStatus.visible:
      return Icons.check_circle_outline;
  }
}

String _statusLabel(ReviewStatus s, AppLocalizations l10n) {
  switch (s) {
    case ReviewStatus.pending:
      return l10n.reviewStatusPending;
    case ReviewStatus.hidden:
      return l10n.reviewStatusHidden;
    case ReviewStatus.rejected:
      return l10n.reviewStatusRejected;
    case ReviewStatus.visible:
      return l10n.reviewStatusVisible;
  }
}

String _statusExplain(ReviewStatus s, AppLocalizations l10n) {
  switch (s) {
    case ReviewStatus.pending:
      return l10n.reviewStatusPendingMsg;
    case ReviewStatus.hidden:
      return l10n.reviewStatusHiddenMsg;
    case ReviewStatus.rejected:
      return l10n.reviewStatusRejectedMsg;
    case ReviewStatus.visible:
      return '';
  }
}

// ============================================================
// Thumb de estabelecimento (foto pequena no header do card)
// ============================================================

class _EstablishmentThumb extends StatelessWidget {
  const _EstablishmentThumb({required this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 40,
        height: 40,
        child: (url == null || url!.isEmpty)
            ? const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.warning],
                  ),
                ),
                child: Icon(Icons.restaurant, color: Colors.white70, size: 18),
              )
            : CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.cover,
                placeholder: (_, _) =>
                    Container(color: const Color(0xFFF2F2F2)),
                errorWidget: (_, _, _) => const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.warning],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

// ============================================================
// Empty / Error states
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
          l10n.myReviewsEmptyTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.myReviewsEmptySubtitle,
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
