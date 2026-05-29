import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/providers/auth_providers.dart';

/// Modal exibido quando o usuário tenta favoritar (ou usar outro
/// recurso autenticado) sem estar logado.
///
/// API estável:
/// ```dart
/// await LoginPromptDialog.show(context);
/// ```
class LoginPromptDialog extends ConsumerWidget {
  const LoginPromptDialog({super.key});

  /// Abre o modal. Retorna `true` se o usuário tocou "Entrar com Google"
  /// (login disparado), `false`/`null` se tocou "Agora não" ou fechou.
  /// O caller normalmente não precisa do retorno — o fluxo de
  /// favoritar exige tap novo após login.
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const LoginPromptDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        l10n.authLoginPromptTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      content: Text(
        l10n.authLoginPromptBody,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          color: AppColors.textSecondary,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            l10n.commonNotNow,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Fecha modal ANTES de disparar — o signInWithGoogle abre
            // o sheet nativo do Google, que não deve ficar atrás do dialog.
            Navigator.of(context).pop(true);
            ref.read(authStateProvider.notifier).signInWithGoogle();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Text(l10n.authSignInWithGoogleShort),
        ),
      ],
    );
  }
}
