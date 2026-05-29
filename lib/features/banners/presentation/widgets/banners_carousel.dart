import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../establishments/presentation/widgets/promo_banner.dart';
import '../../data/models/banner_item.dart';
import '../../data/providers/banners_providers.dart';

/// Carrossel de banners da Home.
///
/// Comportamento:
/// - Loading / erro / lista vazia → renderiza o `PromoBanner` antigo
///   (mesmas dimensões + visual, sem layout shift).
/// - Lista populada → PageView horizontal com `image_url` (`BoxFit.cover`),
///   altura fixa (110px — igual ao PromoBanner) e dots na base.
/// - Toque com `link_url` não nulo → abre o link externo.
/// - Toque com `link_url` nulo → no-op (sem feedback).
class BannersCarousel extends ConsumerWidget {
  const BannersCarousel({super.key});

  /// Mesma altura do PromoBanner — evita layout shift entre os estados
  /// (loading → erro → fallback → carrossel).
  static const double height = 110;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBanners = ref.watch(bannersProvider);
    return asyncBanners.when(
      loading: () => const PromoBanner(),
      error: (_, _) => const PromoBanner(),
      data: (banners) {
        if (banners.isEmpty) return const PromoBanner();
        return _Carousel(banners: banners);
      },
    );
  }
}

class _Carousel extends StatefulWidget {
  const _Carousel({required this.banners});
  final List<BannerItem> banners;

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _open(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } catch (_) {
      // best-effort — URL inválida, sem app capaz de abrir, etc.
      // Não derruba UX nem mostra SnackBar (decisão: o banner já é
      // promocional opcional, falhar silenciosamente é OK).
    }
  }

  @override
  Widget build(BuildContext context) {
    final banners = widget.banners;
    return Container(
      // Mantém EXATAMENTE o mesmo padding do PromoBanner pra ocupar o
      // mesmo espaço na SliverList da Home.
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      height: BannersCarousel.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: banners.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (_, index) {
                final b = banners[index];
                final hasLink =
                    b.linkUrl != null && b.linkUrl!.isNotEmpty;
                return _BannerTile(
                  item: b,
                  onTap: hasLink ? () => _open(b.linkUrl!) : null,
                );
              },
            ),
            if (banners.length > 1)
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(banners.length, (i) {
                    final active = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: active
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BannerTile extends StatelessWidget {
  const _BannerTile({required this.item, required this.onTap});
  final BannerItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final url = item.imageUrl;
    return Semantics(
      label: item.title,
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: (url == null || url.isEmpty)
            ? _Placeholder(title: item.title)
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, _) => const ColoredBox(
                  color: Color(0xFFF2F2F2),
                ),
                errorWidget: (_, _, _) => _Placeholder(title: item.title),
              ),
      ),
    );
  }
}

/// Fallback visual quando `image_url` é null/vazio OU quando a imagem
/// falha em carregar. Gradient nas cores do Festival (mesmo do
/// PromoBanner) com o `title` em branco.
class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.warning],
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
