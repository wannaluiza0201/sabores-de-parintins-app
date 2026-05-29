import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/presentation/profile_screen.dart';
import '../../home/presentation/home_screen.dart';
import '../../map/presentation/map_screen.dart';
import 'placeholder_tab.dart';

/// Shell de navegação por tabs.
///
/// IndexedStack monta TODAS as tabs uma vez e troca qual fica visível —
/// preservando estado (scroll, dados em memória) de cada uma. Diferente
/// de trocar `body:` baseado em `_index`, que desmontaria a tab ao sair.
///
/// O `Scaffold` aqui é o "container" estável; cada tab interna pode ter
/// seu próprio Scaffold com AppBar/FAB locais.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Constrói as tabs dentro do build pra que o label do PlaceholderTab
    // reflita o idioma atual. IndexedStack ainda preserva o estado de
    // cada filho — a chave de identidade é a posição no array.
    final tabs = <Widget>[
      const HomeScreen(),
      PlaceholderTab(label: l10n.navSearch, icon: Icons.search),
      const MapScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: tabs),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primary.withValues(alpha: 0.18),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? AppColors.textPrimary : AppColors.textSecondary,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l10n.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.search),
              label: l10n.navSearch,
            ),
            NavigationDestination(
              icon: const Icon(Icons.map_outlined),
              label: l10n.navMap,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              label: l10n.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
