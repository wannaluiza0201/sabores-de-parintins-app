import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../data/models/establishment.dart';

class EstablishmentCard extends StatelessWidget {
  const EstablishmentCard({super.key, required this.item, this.onTap});

  final Establishment item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Capa — 40% da largura disponível
              Expanded(flex: 4, child: _Cover(url: item.coverPhotoUrl)),
              Expanded(flex: 6, child: _Info(item: item)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    // BUG 2 fix: se a API não trouxer cover_photo_url (caso atual, todos null),
    // cai no placeholder com gradient — mais bonito que o container chapado.
    if (url == null || url!.isEmpty) {
      return const _CoverPlaceholder();
    }
    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.cover,
      // Loading: cinza claro neutro + spinner pequeno (não compete com o card).
      placeholder: (_, _) => Container(
        color: const Color(0xFFF2F2F2),
        alignment: Alignment.center,
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      ),
      // Erro de rede / 404: mesmo fallback do "sem URL" pra consistência visual.
      errorWidget: (_, _, _) => const _CoverPlaceholder(),
    );
  }
}

/// Placeholder visual quando não há foto de capa OU quando o load falha.
/// Gradient nas cores do Festival (amarelo Garantido → laranja Garantido)
/// + ícone de talher grande com baixa opacidade em branco.
class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.warning],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant,
          size: 56,
          color: Colors.white.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.item});
  final Establishment item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 28),
                // Hero: tag igual à usada na tela de detalhe — faz o nome
                // "voar" do card pra Detail. Tag DEVE ser única por
                // estabelecimento; slug garante isso.
                // Material.transparent evita underline amarelo que aparece
                // em texto puro durante o voo do Hero (sem Material wrapper).
                child: Hero(
                  tag: 'establishment-name-${item.slug}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.primaryCategory.name,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        // FavoriteButton — reativo ao favoritesProvider. Anônimo abre
        // LoginPromptDialog; logado faz toggle otimista com animação.
        Positioned(
          top: 6,
          right: 6,
          child: FavoriteButton(
            establishmentId: item.id,
            slug: item.slug,
            size: 20,
          ),
        ),
        // Badge de status
        Positioned(
          bottom: 8,
          right: 8,
          child: _StatusBadge(isOpen: item.isOpenNow),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isOpen});
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOpen ? AppColors.success : const Color(0xFF9E9E9E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOpen ? l10n.statusOpenNow : l10n.statusClosed,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
