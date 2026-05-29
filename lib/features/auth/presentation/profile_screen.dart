import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/providers/auth_providers.dart';
import 'widgets/profile_logged_in_view.dart';
import 'widgets/profile_logged_out_view.dart';

/// Tela da aba "Perfil". Roteia entre as 2 views (logged in / out)
/// e mostra spinner durante loading/initial. Erros viram SnackBar.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen → side effect: mostra SnackBar quando vier um erro novo
    // (sem reconstruir a tela). Compara prev != next pra não duplicar.
    ref.listen<AuthState>(authStateProvider, (prev, next) {
      if (next.status == AuthStatus.error &&
          next.errorMessage != null &&
          next.errorMessage != prev?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.danger,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    final state = ref.watch(authStateProvider);
    switch (state.status) {
      case AuthStatus.initial:
      case AuthStatus.loading:
        return const _Loading();
      case AuthStatus.authenticated:
        return ProfileLoggedInView(user: state.user!);
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        return const ProfileLoggedOutView();
    }
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

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
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
