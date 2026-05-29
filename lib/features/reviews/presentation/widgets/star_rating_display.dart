import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// 5 estrelas read-only com **preenchimento fracionário**.
/// Ex: rating 4.3 → 4 estrelas cheias + 1 estrela 30% preenchida.
///
/// Implementação: cada estrela é um Stack com `Icon` cinza no fundo
/// e `Icon` colorido sobreposto, recortado em largura proporcional.
class StarRatingDisplay extends StatelessWidget {
  const StarRatingDisplay({
    super.key,
    required this.rating,
    this.size = 16,
    this.color,
  });

  final double rating; // 0.0 – 5.0
  final double size;
  final Color? color;

  static const Color _emptyColor = Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    final filled = color ?? AppColors.primary;
    return Semantics(
      // TalkBack lê o agregado como "Nota: 4.3 de 5" em vez de 5 ícones
      // de estrela sem contexto. excludeSemantics oculta os filhos.
      label: AppLocalizations.of(context)!.starsDisplaySemantics(
        rating.toStringAsFixed(1),
      ),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (i) {
          // Fração de preenchimento desta estrela específica (0.0 - 1.0).
          final fraction = (rating - i).clamp(0.0, 1.0);
          return _PartialStar(
            fraction: fraction,
            size: size,
            filled: filled,
          );
        }),
      ),
    );
  }
}

class _PartialStar extends StatelessWidget {
  const _PartialStar({
    required this.fraction,
    required this.size,
    required this.filled,
  });

  final double fraction;
  final double size;
  final Color filled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Icon(
            Icons.star_rounded,
            size: size,
            color: StarRatingDisplay._emptyColor,
          ),
          // ClipRect recorta a estrela cheia em largura proporcional.
          // Width = size * fraction; height continua igual.
          ClipRect(
            clipper: _StarClipper(fraction: fraction),
            child: Icon(Icons.star_rounded, size: size, color: filled),
          ),
        ],
      ),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  const _StarClipper({required this.fraction});
  final double fraction;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * fraction, size.height);

  @override
  bool shouldReclip(_StarClipper oldClipper) =>
      oldClipper.fraction != fraction;
}
