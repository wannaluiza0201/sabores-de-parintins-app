import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Marcador "pino-gota" customizado pro mapa.
///
/// Visual: círculo colorido com ícone branco da categoria + ponta
/// triangular abaixo (CustomPaint), borda branca + sombra.
/// Cor muda com `isOpen` (amarelo primary vs cinza médio).
class EstablishmentMarkerWidget extends StatelessWidget {
  const EstablishmentMarkerWidget({
    super.key,
    required this.categoryIcon,
    required this.isOpen,
    this.onTap,
  });

  final String? categoryIcon;
  final bool isOpen;
  final VoidCallback? onTap;

  /// Tamanho TOTAL do marker (círculo + ponta). Usado pra dimensionar
  /// o `Marker` do flutter_map (width/height/anchor).
  static const double width = 44;
  static const double height = 56;

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? AppColors.primary : const Color(0xFF9E9E9E);

    return GestureDetector(
      onTap: onTap,
      // Sombra "abaixo" do pino pra dar profundidade.
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Ponta — pintada com CustomPaint pra ficar exatamente embaixo do círculo.
          Positioned(
            top: 36,
            child: CustomPaint(
              size: const Size(18, 20),
              painter: _PinPointPainter(color: color),
            ),
          ),
          // Círculo do topo.
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(_iconFor(categoryIcon), color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

/// Pintor da ponta (triângulo) do pino. Cor igual ao círculo,
/// borda branca pra continuidade visual com a borda do círculo.
class _PinPointPainter extends CustomPainter {
  _PinPointPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    // Sombra sutil.
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.25), 2, false);

    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);

    final border = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    // Só desenhamos as 2 bordas laterais (a "borda de cima" se confunde
    // com a base do círculo, deixar limpa fica mais bonito).
    canvas
      ..drawLine(Offset(0, 0), Offset(size.width / 2, size.height), border)
      ..drawLine(
        Offset(size.width, 0),
        Offset(size.width / 2, size.height),
        border,
      );
  }

  @override
  bool shouldRepaint(covariant _PinPointPainter old) => old.color != color;
}

// Reaproveita o mesmo mapeamento dos chips de categoria da Home.
// Slugs vêm da API: coffee, utensils, fish, pizza, hamburger, beer,
// ice-cream, bowl, store.
IconData _iconFor(String? name) {
  return switch (name) {
    'coffee' => Icons.coffee,
    'utensils' => Icons.restaurant,
    'fish' => Icons.set_meal,
    'pizza' => Icons.local_pizza,
    'hamburger' => Icons.lunch_dining,
    'beer' => Icons.sports_bar,
    'ice-cream' => Icons.icecream,
    'bowl' => Icons.ramen_dining,
    'store' => Icons.store,
    _ => Icons.store,
  };
}
