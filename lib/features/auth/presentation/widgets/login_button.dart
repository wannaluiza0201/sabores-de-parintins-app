import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/providers/auth_providers.dart';

/// Botão "Entre com Google" — estilo Material 3 (branco com borda).
///
/// Loading state: substitui texto + ícone por CircularProgressIndicator.
/// Erros vêm pelo `authStateProvider.errorMessage` (a tela mostra SnackBar
/// via ref.listen).
class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateProvider);
    final isLoading = state.status == AuthStatus.loading;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: isLoading
              ? null
              : () => ref.read(authStateProvider.notifier).signInWithGoogle(),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFDADCE0), width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primary,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _GoogleGLogo(size: 22),
                    const SizedBox(width: 12),
                    Text(
                      AppLocalizations.of(context)!.authSignInWithGoogle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Logo "G" do Google desenhada com CustomPaint (não usa asset).
/// As 4 cores oficiais — azul, vermelho, amarelo, verde — pintadas em
/// arcos. Aproximação visual; pra fidelidade total trocar pelo SVG oficial.
class _GoogleGLogo extends StatelessWidget {
  const _GoogleGLogo({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleGPainter()),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  static const _blue = Color(0xFF4285F4);
  static const _red = Color(0xFFEA4335);
  static const _yellow = Color(0xFFFBBC05);
  static const _green = Color(0xFF34A853);

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final center = Offset(r, r);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.22;

    // 4 arcos de 90° cada — aproximação simplificada do logo.
    final rect = Rect.fromCircle(center: center, radius: r * 0.78);

    paint.color = _blue;
    canvas.drawArc(rect, -0.5, 1.7, false, paint);

    paint.color = _red;
    canvas.drawArc(rect, 3.14 + 0.4, 1.3, false, paint);

    paint.color = _yellow;
    canvas.drawArc(rect, 2.0, 1.2, false, paint);

    paint.color = _green;
    canvas.drawArc(rect, 0.8, 1.2, false, paint);

    // "Risquinho" horizontal típico do G (do azul indo pro centro).
    final barPaint = Paint()
      ..color = _blue
      ..strokeWidth = size.width * 0.22
      ..style = PaintingStyle.fill;
    final barRect = Rect.fromLTWH(r, r - r * 0.13, r * 0.7, r * 0.26);
    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant _GoogleGPainter old) => false;
}
