import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/models/feature.dart';

/// Grid 2-colunas de comodidades (Wi-Fi, ar-condicionado, etc.).
///
/// Lista vazia → texto itálico cinza "Sem comodidades cadastradas".
class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({super.key, required this.features});

  final List<Feature> features;

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          AppLocalizations.of(context)!.amenitiesEmpty,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: features.map((f) => _FeatureChip(feature: f)).toList(),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.feature});
  final Feature feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_iconFor(feature.slug), size: 16, color: AppColors.textPrimary),
          const SizedBox(width: 6),
          Text(
            feature.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// Mapa slug → ícone Material. Slugs vêm do backend (`wifi`,
// `ar-condicionado`, `aceita-cartao`, `aceita-pix`, `ifood`, etc.).
IconData _iconFor(String slug) {
  return switch (slug) {
    'wifi' => Icons.wifi,
    'ar-condicionado' => Icons.ac_unit,
    'aceita-cartao' => Icons.credit_card,
    'aceita-pix' => Icons.pix,
    'ifood' => Icons.delivery_dining,
    'estacionamento' => Icons.local_parking,
    'pet-friendly' => Icons.pets,
    'acessivel' => Icons.accessible,
    _ => Icons.check_circle_outline,
  };
}
