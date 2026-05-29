import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Chip vertical: ícone redondo + label. Usado no carousel da Home.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.iconName,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  /// Nome do ícone vindo da API (Font Awesome style) ou `'__all__'`
  /// para o chip fixo "Todos". Nullable porque a API pode retornar
  /// `icon: null` em categorias mal cadastradas — caímos no ícone padrão.
  final String? iconName;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Selecionado: círculo PREENCHIDO em primary + ícone branco + label primary bold.
    // Inativo: círculo translúcido + ícone/label textPrimary.
    final iconColor = selected ? Colors.white : AppColors.textPrimary;
    final bg = selected
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.10);
    final labelColor = selected ? AppColors.primary : AppColors.textPrimary;

    return SizedBox(
      width: 80,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(_iconFor(iconName), color: iconColor, size: 26),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: labelColor,
                  // BUG 1 fix: line-height apertado pra 2 linhas caberem sem overflow.
                  height: 1.15,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mapa nome-da-API → IconData. Valores conhecidos vêm do endpoint
// /categories: coffee, utensils, fish, pizza, hamburger, beer, ice-cream,
// bowl, store. `__all__` é convenção interna pro chip fixo "Todos".
IconData _iconFor(String? name) {
  return switch (name) {
    '__all__' => Icons.apps_rounded,
    'coffee' => Icons.coffee,
    'utensils' => Icons.restaurant,
    'fish' => Icons.set_meal,
    'pizza' => Icons.local_pizza,
    'hamburger' => Icons.lunch_dining,
    'beer' => Icons.sports_bar,
    'ice-cream' => Icons.icecream,
    'bowl' => Icons.ramen_dining,
    'store' => Icons.store,
    _ => Icons.restaurant_menu,
  };
}
