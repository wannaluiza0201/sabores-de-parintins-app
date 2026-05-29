import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../settings/data/providers/locale_providers.dart';
import '../../data/models/auth_user.dart';
import '../../data/providers/auth_providers.dart';

/// View pra quando o usuário ESTÁ logado. Avatar + nome + email + menu.
class ProfileLoggedInView extends ConsumerWidget {
  const ProfileLoggedInView({super.key, required this.user});

  final AuthUser user;

  Future<void> _confirmAndSignOut(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.profileSignOutConfirmTitle),
        content: Text(l10n.profileSignOutConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.profileSignOutCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.profileSignOutConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(authStateProvider.notifier).signOut();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.profileSignedOutToast),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeControllerProvider);

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
          IconButton(
            onPressed: () {
              // Configurações — placeholder por enquanto.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${l10n.profileSettings} — ${l10n.profileSettingsSubtitle}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          Center(child: _Avatar(user: user)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              user.name.isEmpty ? '—' : user.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              user.email,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _MenuItem(
            icon: Icons.favorite_border,
            label: l10n.profileFavorites,
            subtitle: l10n.profileFavoritesSubtitle,
            onTap: () => context.push('/favorites'),
          ),
          _MenuItem(
            icon: Icons.star_border,
            label: l10n.profileReviews,
            subtitle: l10n.profileReviewsSubtitle,
            onTap: () => context.push('/me/reviews'),
          ),
          _MenuItem(
            icon: Icons.language,
            label: l10n.profileLanguage,
            subtitle: _localeName(currentLocale, l10n),
            onTap: () => context.push('/settings/language'),
          ),
          _MenuItem(
            icon: Icons.settings_outlined,
            label: l10n.profileSettings,
            subtitle: l10n.profileSettingsSubtitle,
          ),
          const Divider(height: 32, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.danger),
            title: Text(
              l10n.profileSignOut,
              style: const TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () => _confirmAndSignOut(context, ref),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Nome legível do idioma atualmente em uso (pra mostrar no subtitle
/// do item "Idioma" no Perfil).
String _localeName(Locale? locale, AppLocalizations l10n) {
  if (locale == null) return l10n.languageSystemDefault;
  switch (locale.languageCode) {
    case 'pt':
      return l10n.languagePortuguese;
    case 'en':
      return l10n.languageEnglish;
    case 'es':
      return l10n.languageSpanish;
    default:
      return l10n.languageSystemDefault;
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.user});
  final AuthUser user;

  String get _initials {
    final parts = user.name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return user.email.isNotEmpty ? user.email[0].toUpperCase() : '?';
    }
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final url = user.avatarUrl;
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: (url == null || url.isEmpty)
          ? Center(
              child: Text(
                _initials,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            )
          : CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: const Color(0xFFF2F2F2)),
              errorWidget: (_, _, _) => Center(
                child: Text(
                  _initials,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  // Quando null, mostra SnackBar "em breve" (placeholder). Quando
  // fornecido, executa o callback (ex: navegar pra Favoritos).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$label — $subtitle'),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          },
    );
  }
}
