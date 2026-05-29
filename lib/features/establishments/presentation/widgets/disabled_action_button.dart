import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Botão circular de ação com estado "habilitado" e "desabilitado".
///
/// Quando desabilitado, NÃO some — fica em opacidade baixa + cor cinza,
/// e o tap mostra um SnackBar explicando o motivo (graceful degradation).
/// Isso comunica ao usuário "esse recurso existe mas o estabelecimento
/// não preencheu" sem esconder a UI.
class DisabledActionButton extends StatelessWidget {
  const DisabledActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isEnabled,
    required this.enabledColor,
    required this.disabledMessage,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool isEnabled;
  final Color enabledColor;
  final String disabledMessage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bg = isEnabled ? enabledColor : const Color(0xFFE0E0E0);
    final iconColor = isEnabled ? Colors.white : const Color(0xFF9E9E9E);
    final labelColor = isEnabled
        ? AppColors.textPrimary
        : AppColors.textSecondary;

    void handleTap() {
      if (isEnabled) {
        onPressed?.call();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(disabledMessage),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: InkWell(
        onTap: handleTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
