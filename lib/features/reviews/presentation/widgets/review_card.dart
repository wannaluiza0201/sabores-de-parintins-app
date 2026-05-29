import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/models/review.dart';
import 'star_rating_display.dart';

/// Card de exibição de uma Review. Usado em 3 contextos:
/// 1. Lista pública na detail (3 últimas)
/// 2. Tela "Todas as avaliações"
/// 3. Tela "Minhas avaliações" (variação `MyReviewCard`, separada).
///
/// Comportamento por contexto:
/// - `isMine == true` → mostra botão "✏️ Editar" no canto superior dir.
/// - `isMine == false` → mostra "..." que chama `onReport`.
class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
    required this.review,
    this.isMine = false,
    this.onReport,
    this.onEdit,
  });

  final Review review;
  final bool isMine;
  final VoidCallback? onReport;
  final VoidCallback? onEdit;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final r = widget.review;
    final hasLongComment = (r.comment ?? '').length > 200;
    // user é nullable porque /me/reviews omite (redundante — sou eu).
    // Em listas públicas sempre vem, mas defendemos contra null aqui.
    final user = r.user;
    final userName = user?.name ?? l10n.reviewDefaultUserName;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- Topo: avatar + nome + data + ação ----------
          Row(
            children: [
              _Avatar(url: user?.avatarUrl, name: userName),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      _relativeDate(r.createdAt, l10n),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isMine && widget.onEdit != null)
                TextButton.icon(
                  onPressed: widget.onEdit,
                  icon: const Icon(Icons.edit, size: 16),
                  label: Text(l10n.commonEdit),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              else if (!widget.isMine && widget.onReport != null)
                IconButton(
                  onPressed: widget.onReport,
                  icon: const Icon(Icons.more_horiz),
                  iconSize: 20,
                  visualDensity: VisualDensity.compact,
                  tooltip: l10n.reviewReportTooltip,
                ),
            ],
          ),
          const SizedBox(height: 8),

          // -------- Estrelas + rating numérico ----------
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

          // -------- Comentário (truncado em 4 linhas com "ver mais") --------
          if ((r.comment ?? '').isNotEmpty) ...[
            const SizedBox(height: 8),
            AnimatedSize(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: Text(
                r.comment!,
                maxLines: _expanded ? null : 4,
                overflow: _expanded ? null : TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (hasLongComment)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _expanded ? l10n.commonSeeLess : l10n.commonSeeMore,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.info,
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// Avatar com fallback de iniciais
// ============================================================

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.name});
  final String? url;
  final String name;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: (url == null || url!.isEmpty)
          ? Center(
              child: Text(
                _initials,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            )
          : CachedNetworkImage(
              imageUrl: url!,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: const Color(0xFFF2F2F2)),
              errorWidget: (_, _, _) => Center(
                child: Text(
                  _initials,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
    );
  }
}

// ============================================================
// Helper de data relativa — usa as chaves ICU plural do .arb
// ============================================================

String _relativeDate(DateTime when, AppLocalizations l10n) {
  final diff = DateTime.now().difference(when);
  if (diff.inMinutes < 1) return l10n.dateJustNow;
  if (diff.inMinutes < 60) return l10n.dateMinutesAgo(diff.inMinutes);
  if (diff.inHours < 24) return l10n.dateHoursAgo(diff.inHours);
  if (diff.inDays < 7) return l10n.dateDaysAgo(diff.inDays);
  if (diff.inDays < 30) {
    final w = (diff.inDays / 7).floor();
    return l10n.dateWeeksAgo(w);
  }
  if (diff.inDays < 365) {
    final m = (diff.inDays / 30).floor();
    return l10n.dateMonthsAgo(m);
  }
  final y = (diff.inDays / 365).floor();
  return l10n.dateYearsAgo(y);
}
