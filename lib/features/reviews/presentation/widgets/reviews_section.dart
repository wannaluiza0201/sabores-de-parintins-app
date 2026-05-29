import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/data/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/login_prompt_dialog.dart';
import '../../../establishments/data/models/establishment_detail.dart';
import '../../../establishments/data/models/establishment_mini.dart';
import '../../data/providers/establishment_reviews_provider.dart';
import 'review_card.dart';
import 'review_form_sheet.dart';
import 'report_review_dialog.dart';
import 'star_rating_display.dart';

/// Bloco completo de Avaliações na tela de detalhe.
/// Composto por: agregado + botão avaliar/editar + 3 últimas reviews
/// + botão "Ver todas as avaliações".
class ReviewsSection extends ConsumerWidget {
  const ReviewsSection({super.key, required this.detail});

  final EstablishmentDetail detail;

  /// Adapter: a detail tem EstablishmentDetail (model rico); o sheet
  /// agora aceita EstablishmentMini (só 5 campos). Bem mais limpo que
  /// montar um Establishment "lite" com 12 campos.
  EstablishmentMini _asMini() => EstablishmentMini(
        id: detail.id,
        slug: detail.slug,
        name: detail.name,
        coverPhotoUrl: detail.coverPhotoUrl,
        primaryCategory: detail.primaryCategory,
      );

  void _openReviewSheet(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.read(isLoggedInProvider);
    if (!loggedIn) {
      LoginPromptDialog.show(context);
      return;
    }
    ReviewFormSheet.show(
      context,
      establishment: _asMini(),
      existingReview: detail.userReview,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // Lista pública (top 3) — provider é family por slug.
    final listState = ref.watch(establishmentReviewsProvider(detail.slug));
    final topThree = listState.items.take(3).toList(growable: false);
    final isEmpty = detail.reviewsCount == 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -------- Título da seção ---------
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Text(
            l10n.reviewsSectionTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        // -------- Agregado (ou empty state) ---------
        if (isEmpty)
          _EmptyAggregate(onTapReview: () => _openReviewSheet(context, ref))
        else
          _Aggregate(detail: detail),

        const SizedBox(height: 12),

        // -------- Botão Avaliar / Editar ---------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () => _openReviewSheet(context, ref),
              icon: Icon(
                detail.userReview == null ? Icons.star_border : Icons.edit,
                size: 18,
              ),
              label: Text(
                detail.userReview == null
                    ? l10n.reviewActionAdd
                    : l10n.reviewActionEdit,
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // -------- 3 últimas reviews (staggered) ---------
        if (topThree.isNotEmpty) ...[
          for (int i = 0; i < topThree.length; i++)
            _StaggeredItem(
              delayMs: 80 * i,
              child: ReviewCard(
                review: topThree[i],
                isMine: detail.userReview?.id == topThree[i].id,
                onEdit: detail.userReview?.id == topThree[i].id
                    ? () => _openReviewSheet(context, ref)
                    : null,
                onReport: () => ReportReviewDialog.show(
                  context,
                  reviewId: topThree[i].id,
                ),
              ),
            ),
          const SizedBox(height: 8),
          // -------- Ver todas ---------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton.icon(
              // `extra` passa o nome em runtime — evita a tela de
              // "Avaliações" ter que refetchar só pra mostrar o subtitle.
              onPressed: () => context.push(
                '/establishment/${detail.slug}/reviews',
                extra: detail.name,
              ),
              icon: const Icon(Icons.arrow_forward),
              label: Text(l10n.reviewSeeAll(detail.reviewsCount)),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.info,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ============================================================
// Agregado (nota grande + breakdown)
// ============================================================

class _Aggregate extends StatelessWidget {
  const _Aggregate({required this.detail});
  final EstablishmentDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final avg = detail.reviewsAvgRating ?? 0.0;
    final reduce = MediaQuery.disableAnimationsOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bloco da nota grande com animação de contagem.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TweenAnimationBuilder anima de 0 → avg em 800ms.
              // Builder roda a cada frame com `value` interpolado.
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: avg),
                duration: reduce
                    ? Duration.zero
                    : const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (_, value, _) => Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              StarRatingDisplay(rating: avg, size: 14),
              const SizedBox(height: 2),
              Text(
                l10n.reviewsAggregateCount(detail.reviewsCount),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 28),
          // Breakdown dos eixos (omite os null).
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (detail.reviewsAvgFood != null)
                  _AxisLine(
                    label: l10n.reviewAxisFood,
                    value: detail.reviewsAvgFood!,
                  ),
                if (detail.reviewsAvgService != null)
                  _AxisLine(
                    label: l10n.reviewAxisService,
                    value: detail.reviewsAvgService!,
                  ),
                if (detail.reviewsAvgAmbience != null)
                  _AxisLine(
                    label: l10n.reviewAxisAmbience,
                    value: detail.reviewsAvgAmbience!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisLine extends StatelessWidget {
  const _AxisLine({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star_rounded, size: 12, color: AppColors.primary),
        ],
      ),
    );
  }
}

// ============================================================
// Empty state (sem avaliações ainda)
// ============================================================

class _EmptyAggregate extends StatelessWidget {
  const _EmptyAggregate({required this.onTapReview});
  final VoidCallback onTapReview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 40,
              color: AppColors.primary.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.reviewsEmptyTitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.reviewsEmptySubtitleDetail,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Item com entrada animada (fade + slide-up com delay)
// ============================================================

class _StaggeredItem extends StatefulWidget {
  const _StaggeredItem({required this.child, required this.delayMs});
  final Widget child;
  final int delayMs;

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Delay calculado por índice → efeito cascata na primeira carga.
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final duration = reduce ? Duration.zero : const Duration(milliseconds: 320);
    return AnimatedSlide(
      duration: duration,
      curve: Curves.easeOut,
      offset: _visible ? Offset.zero : const Offset(0, 0.15),
      child: AnimatedOpacity(
        duration: duration,
        opacity: _visible ? 1.0 : 0.0,
        child: widget.child,
      ),
    );
  }
}
