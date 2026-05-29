import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import 'login_button.dart';

/// View pra quando o usuário NÃO está logado. Mostra benefícios + CTA.
class ProfileLoggedOutView extends StatelessWidget {
  const ProfileLoggedOutView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          l10n.profileTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          // Seleção de idioma — acessível mesmo sem login, pra um
          // visitante estrangeiro conseguir trocar pro idioma dele
          // antes de fazer qualquer coisa.
          IconButton(
            tooltip: l10n.profileLanguage,
            onPressed: () => context.push('/settings/language'),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Icon(
                Icons.account_circle,
                size: 120,
                color: AppColors.primary.withValues(alpha: 0.85),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.profileLoggedOutHeadline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.profileLoggedOutBody,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 2),
              const LoginButton(),
              const SizedBox(height: 16),
              Text(
                l10n.profileLoggedOutTerms,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
