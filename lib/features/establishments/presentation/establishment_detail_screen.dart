import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../favorites/presentation/widgets/favorite_button.dart';
import '../../reviews/presentation/widgets/reviews_section.dart';
import '../data/models/establishment_detail.dart';
import '../data/models/photo.dart';
import '../data/providers/establishment_detail_provider.dart';
import 'widgets/action_buttons_row.dart';
import 'widgets/address_block.dart';
import 'widgets/features_grid.dart';
import 'widgets/hours_table.dart';
import 'widgets/photo_carousel.dart';

/// Tela de detalhe do estabelecimento. Recebe o slug via path param do
/// go_router e busca os dados em dois providers (detail + photos).
class EstablishmentDetailScreen extends ConsumerWidget {
  const EstablishmentDetailScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(establishmentDetailProvider(slug));
    final photosAsync = ref.watch(establishmentPhotosProvider(slug));

    return Scaffold(
      backgroundColor: Colors.white,
      body: detailAsync.when(
        loading: () => const _LoadingSkeleton(),
        error: (err, _) => _ErrorState(
          slug: slug,
          message: '$err',
          onRetry: () {
            ref.invalidate(establishmentDetailProvider(slug));
            ref.invalidate(establishmentPhotosProvider(slug));
          },
        ),
        data: (detail) => _DetailBody(detail: detail, photosAsync: photosAsync),
      ),
    );
  }
}

// ============================================================
// Corpo principal (data state)
// ============================================================

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail, required this.photosAsync});

  final EstablishmentDetail detail;
  final AsyncValue<List<Photo>> photosAsync;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        // ---- Galeria + botões sobrepostos ----
        SliverToBoxAdapter(
          child: Stack(
            children: [
              // Photos vem por provider separado. Enquanto carrega,
              // mostra o placeholder gradient (mesmo do erro/sem fotos).
              photosAsync.when(
                // Loading/erro: mostra o carousel "vazio" (cai no
                // placeholder gradient) — não esconde a área.
                loading: () => const PhotoCarousel(photos: []),
                error: (_, _) => const PhotoCarousel(photos: []),
                data: (photos) => PhotoCarousel(photos: photos),
              ),
              const Positioned(top: 8, left: 8, child: _OverlayBackButton()),
              Positioned(
                top: 8,
                right: 8,
                child: _OverlayFavoriteButton(
                  id: detail.id,
                  slug: detail.slug,
                ),
              ),
            ],
          ),
        ),

        // ---- Cabeçalho: nome + categoria + status ----
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero: tag única por slug, faz o nome "voar" do card
                      // da Home pra cá. Material.transparent evita underline
                      // amarelo que aparece sem Material wrapper em Hero.
                      Hero(
                        tag: 'establishment-name-${detail.slug}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            detail.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _CategoryChipMini(name: detail.primaryCategory.name),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              detail.neighborhood,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _StatusBadge(
                  isOpen: detail.isOpenNow,
                  message: detail.currentStatusMessage,
                ),
              ],
            ),
          ),
        ),

        // ---- Ações ----
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ActionButtonsRow(detail: detail),
          ),
        ),

        const SliverToBoxAdapter(child: Divider(height: 1)),

        // ---- Descrição ----
        SliverToBoxAdapter(
          child: _Section(
            title: l10n.detailSectionAbout,
            // Variável local pra promoção de tipo: depois do check de
            // null/empty, `desc` vira String? mas o `??` resolve.
            child: Builder(
              builder: (_) {
                final desc = detail.description;
                final hasDesc = desc != null && desc.isNotEmpty;
                return Text(
                  hasDesc ? desc : l10n.detailDescriptionEmpty,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: hasDesc
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontStyle: hasDesc
                        ? FontStyle.normal
                        : FontStyle.italic,
                  ),
                );
              },
            ),
          ),
        ),

        // ---- Horários ----
        SliverToBoxAdapter(
          child: _Section(
            title: l10n.detailSectionHours,
            child: HoursTable(hours: detail.businessHours),
          ),
        ),

        // ---- Endereço ----
        SliverToBoxAdapter(
          child: _Section(
            title: l10n.detailSectionAddress,
            child: AddressBlock(detail: detail),
          ),
        ),

        // ---- Features ----
        SliverToBoxAdapter(
          child: _Section(
            title: l10n.detailSectionAmenities,
            child: FeaturesGrid(features: detail.features),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        const SliverToBoxAdapter(child: Divider(height: 1)),

        // -------- Avaliações (PASSO 7) --------
        SliverToBoxAdapter(child: ReviewsSection(detail: detail)),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

// ============================================================
// Subwidgets
// ============================================================

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _OverlayBackButton extends StatelessWidget {
  const _OverlayBackButton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black.withValues(alpha: 0.35),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => context.pop(),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}

/// Espelha o _OverlayBackButton (mesmo fundo translúcido escuro),
/// mas hospeda o FavoriteButton — que já tem seu próprio gesture +
/// animação. Inactive branco pra contraste sobre fotos coloridas.
class _OverlayFavoriteButton extends StatelessWidget {
  const _OverlayFavoriteButton({required this.id, required this.slug});

  final int id;
  final String slug;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: FavoriteButton(
          establishmentId: id,
          slug: slug,
          size: 22,
          inactiveColor: Colors.white,
        ),
      ),
    );
  }
}

class _CategoryChipMini extends StatelessWidget {
  const _CategoryChipMini({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isOpen, required this.message});
  final bool isOpen;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isOpen ? AppColors.success : const Color(0xFF9E9E9E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        // current_status_message vem com texto rico; cai no fallback
        // (vazio? raro, mas defensivo) pra "Aberto"/"Fechado".
        message.isNotEmpty
            ? message
            : (isOpen ? l10n.statusOpen : l10n.statusClosed),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================
// Loading skeleton
// ============================================================

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Container(
                height: PhotoCarousel.height,
                color: const Color(0xFFF2F2F2),
              ),
              const Positioned(top: 8, left: 8, child: _OverlayBackButton()),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList.list(
            children: const [
              _SkeletonBox(width: 200, height: 24),
              SizedBox(height: 12),
              _SkeletonBox(width: 120, height: 14),
              SizedBox(height: 24),
              _SkeletonBox(width: double.infinity, height: 80),
              SizedBox(height: 16),
              _SkeletonBox(width: double.infinity, height: 60),
              SizedBox(height: 16),
              _SkeletonBox(width: double.infinity, height: 160),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

// ============================================================
// Error state
// ============================================================

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.slug,
    required this.message,
    required this.onRetry,
  });
  final String slug;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: 64,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.detailErrorTitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.commonTryAgain),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(top: 8, left: 8, child: _OverlayBackButton()),
        ],
      ),
    );
  }
}
