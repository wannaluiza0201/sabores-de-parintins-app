import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../establishments/data/models/establishment.dart';

/// Card flutuante exibido na base do mapa ao tocar num marcador.
///
/// Conteúdo: foto/placeholder à esquerda, nome+categoria+status à direita,
/// distância (se userPosition disponível) e botão "Ver detalhes".
class MapBottomCard extends StatelessWidget {
  const MapBottomCard({
    super.key,
    required this.item,
    required this.userPosition,
    required this.onClose,
  });

  final Establishment item;
  final Position? userPosition;
  final VoidCallback onClose;

  static const double height = 138;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black54,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      color: Colors.white,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Photo(url: item.coverPhotoUrl),
              const SizedBox(width: 12),
              Expanded(child: _Info(item: item, userPosition: userPosition)),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, size: 20),
                color: AppColors.textSecondary,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 80,
        height: 80,
        child: (url == null || url!.isEmpty)
            ? const _PhotoPlaceholder()
            : CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: const Color(0xFFF2F2F2)),
                errorWidget: (_, _, _) => const _PhotoPlaceholder(),
              ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

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
          size: 32,
          color: Colors.white.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.item, required this.userPosition});
  final Establishment item;
  final Position? userPosition;

  String? _distanceText(AppLocalizations l10n) {
    final pos = userPosition;
    if (pos == null) return null;
    // Geolocator.distanceBetween retorna em METROS (Vincenty/Haversine).
    final meters = Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      item.latitude,
      item.longitude,
    );
    if (meters < 1000) return l10n.mapDistanceMeters(meters.round());
    return l10n.mapDistanceKilometers((meters / 1000).toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dist = _distanceText(l10n);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${item.primaryCategory.name} • ${item.isOpenNow ? l10n.statusOpenNow : l10n.statusClosed}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: item.isOpenNow ? AppColors.success : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (dist != null) ...[
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(
                Icons.place_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 2),
              Text(
                dist,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
        const Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () => context.push('/establishment/${item.slug}'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(l10n.mapViewDetails),
          ),
        ),
      ],
    );
  }
}
