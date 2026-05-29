import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/providers/locale_providers.dart';

/// Tela de seleção de idioma. Acessada via `/settings/language`.
///
/// 4 opções:
/// - Padrão do sistema (`null`)
/// - Português (Brasil) (`Locale('pt')`)
/// - Inglês (`Locale('en')`)
/// - Espanhol (`Locale('es')`)
///
/// Mudança aplica IMEDIATAMENTE — o `MaterialApp` reconstrói com o novo
/// locale e todas as strings via `AppLocalizations.of(context)` saem
/// no novo idioma sem precisar de restart.
class LanguagePickerScreen extends ConsumerWidget {
  const LanguagePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = ref.watch(localeControllerProvider);

    final options = <_LangOption>[
      _LangOption(
        locale: null,
        flag: '🌐',
        label: l10n.languageSystemDefault,
        subtitle: l10n.languageSystemDefaultSubtitle,
      ),
      _LangOption(
        locale: const Locale('pt'),
        flag: '🇧🇷',
        label: l10n.languagePortuguese,
      ),
      _LangOption(
        locale: const Locale('en'),
        flag: '🇺🇸',
        label: l10n.languageEnglish,
      ),
      _LangOption(
        locale: const Locale('es'),
        flag: '🇪🇸',
        label: l10n.languageSpanish,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          l10n.languagePickerTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: options.length,
        separatorBuilder: (_, _) =>
            const Divider(height: 1, indent: 72, endIndent: 16),
        itemBuilder: (context, index) {
          final opt = options[index];
          final selected = current == opt.locale;
          return ListTile(
            leading: SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  opt.flag,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            title: Text(
              opt.label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: opt.subtitle == null
                ? null
                : Text(
                    opt.subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
            trailing: selected
                ? const Icon(Icons.check_circle, color: AppColors.primary)
                : const SizedBox(width: 24),
            onTap: () => ref
                .read(localeControllerProvider.notifier)
                .setLocale(opt.locale),
          );
        },
      ),
    );
  }
}

class _LangOption {
  const _LangOption({
    required this.locale,
    required this.flag,
    required this.label,
    this.subtitle,
  });

  final Locale? locale;
  final String flag;
  final String label;
  final String? subtitle;
}
