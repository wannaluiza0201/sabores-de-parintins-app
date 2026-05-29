import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../auth/data/providers/auth_providers.dart';
import '../../auth/presentation/widgets/login_prompt_dialog.dart';
import '../../banners/data/providers/banners_providers.dart';
import '../../banners/presentation/widgets/banners_carousel.dart';
import '../../establishments/data/models/category.dart';
import '../../establishments/data/models/establishment.dart';
import '../../establishments/data/providers/establishment_providers.dart';
import '../../establishments/presentation/widgets/category_chip.dart';
import '../../establishments/presentation/widgets/establishment_card.dart';
import '../data/providers/home_filters.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final establishmentsAsync = ref.watch(establishmentsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      // Column com Expanded no scroll: header fica FIXO no topo, só o
      // conteúdo abaixo rola. O pull-to-refresh continua funcionando
      // porque está aplicado ao CustomScrollView de dentro.
      body: Column(
        children: [
          const _HeaderWithSearch(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Limpa o cache local de banners ANTES de invalidar —
                // senão o repository retornaria o cache "válido"
                // (< 10min) ignorando o gesto explícito do usuário.
                await ref.read(bannersCacheServiceProvider).clear();
                ref.invalidate(establishmentsProvider);
                ref.invalidate(categoriesProvider);
                ref.invalidate(bannersProvider);
                await Future.wait([
                  ref.read(establishmentsProvider.future),
                  ref.read(categoriesProvider.future),
                  ref.read(bannersProvider.future),
                ]);
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  SliverToBoxAdapter(
                    child: _CategoriesRow(asyncCategories: categoriesAsync),
                  ),
                  const SliverToBoxAdapter(child: BannersCarousel()),
                  SliverToBoxAdapter(
                    child: _SectionTitle(
                      AppLocalizations.of(context)!.homeEstablishmentsTitle,
                    ),
                  ),
                  _EstablishmentsSliver(asyncList: establishmentsAsync),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Header amarelo + search bar flutuante
// ============================================================

class _HeaderWithSearch extends StatelessWidget {
  const _HeaderWithSearch();

  static const double _headerHeight = 180;
  static const double _searchOverflow = 25;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _headerHeight + _searchOverflow + 25,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: _headerHeight,
            width: double.infinity,
            color: AppColors.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Sabores de Parintins',
                        style: GoogleFonts.sacramento(
                          fontSize: 38,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),
                    const _HeaderFavoriteShortcut(),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: _SearchBar(),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  const _SearchBar();
  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    // CUIDADO: cancela o timer anterior, senão múltiplos timers disparam
    // em sequência e o estado vai flutuar.
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).set(value);
    });
  }

  // Botão X explícito — também zera categoria pra voltar pra "Todos"
  // (decisão de UX: ação intencional do usuário = reset completo).
  void _clear() {
    _debounce?.cancel();
    _controller.clear();
    // X zera apenas a busca. Pra "ver todas as categorias", o usuário
    // toca no chip "Todos".
    ref.read(searchQueryProvider.notifier).set('');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(28),
      color: Colors.white,
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.search, color: AppColors.textSecondary, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.homeSearchHint,
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
            // ValueListenableBuilder ouve o controller direto (sem
            // setState) pra alternar entre o ícone tune e o X.
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (_, value, _) {
                if (value.text.isEmpty) {
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      color: AppColors.textPrimary,
                      size: 22,
                    ),
                  );
                }
                return IconButton(
                  onPressed: _clear,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                );
              },
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Carousel horizontal de categorias
// ============================================================

class _CategoriesRow extends ConsumerWidget {
  const _CategoriesRow({required this.asyncCategories});
  final AsyncValue<List<Category>> asyncCategories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedCategoryIdProvider);

    void selectCategory(int? id) {
      final current = ref.read(selectedCategoryIdProvider);
      // Tap no chip já selecionado → deseleciona (volta pra "Todos").
      final next = (id == current) ? null : id;
      ref.read(selectedCategoryIdProvider.notifier).set(next);
      // Busca e categoria agora combinam (AND) — não limpamos uma quando
      // a outra muda.
    }

    return SizedBox(
      // BUG 1 fix: 110 não acomodava labels em 2 linhas (ex: "Café da manhã").
      // 124 = 78 (ícone+paddings fixos) + ~32 (2 linhas de fontSize 11 com height 1.15) + folga.
      height: 124,
      child: asyncCategories.when(
        loading: () => const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        error: (_, _) => Center(
          child: Text(
            AppLocalizations.of(context)!.homeCategoriesError,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
        data: (categories) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: categories.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 4),
            itemBuilder: (context, index) {
              if (index == 0) {
                return CategoryChip(
                  iconName: '__all__',
                  label: AppLocalizations.of(context)!.homeCategoryAll,
                  selected: selectedId == null,
                  onTap: () => selectCategory(null),
                );
              }
              final cat = categories[index - 1];
              return CategoryChip(
                iconName: cat.icon,
                label: cat.name,
                selected: selectedId == cat.id,
                onTap: () => selectCategory(cat.id),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// Lista vertical de estabelecimentos
// ============================================================

class _EstablishmentsSliver extends ConsumerWidget {
  const _EstablishmentsSliver({required this.asyncList});
  final AsyncValue<List<Establishment>> asyncList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncList.when(
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.error_outline, color: AppColors.danger, size: 32),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.homeEstablishmentsError,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                '$err',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      data: (apiList) {
        // Lista filtrada vem do provider derivado. Pode estar vazia
        // mesmo com apiList cheia (filtro não bateu nada).
        final filtered = ref.watch(filteredEstablishmentsProvider);

        if (filtered.isEmpty && apiList.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 48,
                horizontal: 24,
              ),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.search_off,
                      size: 64,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.homeEstablishmentsEmpty,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SliverList.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return EstablishmentCard(
              item: item,
              // go_router: navega empilhando a rota /establishment/:slug.
              // O builder em app_router.dart extrai o slug e monta a tela.
              onTap: () => context.push('/establishment/${item.slug}'),
            );
          },
        );
      },
    );
  }
}

// ============================================================
// Section title
// ============================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// ============================================================
// Atalho de favoritos no header (substitui o antigo sino).
// Anônimo → modal de login. Logado → empilha a tela /favorites.
// ============================================================

class _HeaderFavoriteShortcut extends ConsumerWidget {
  const _HeaderFavoriteShortcut();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        final loggedIn = ref.read(isLoggedInProvider);
        if (!loggedIn) {
          LoginPromptDialog.show(context);
          return;
        }
        context.push('/favorites');
      },
      icon: const Icon(
        Icons.favorite_border,
        color: Colors.white,
        size: 26,
      ),
      tooltip: AppLocalizations.of(context)!.profileFavorites,
    );
  }
}
