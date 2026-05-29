import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/photo.dart';

/// Galeria de fotos no topo da tela de detalhe.
///
/// - PageView horizontal com altura fixa (280px).
/// - Dots indicadores na base (escondidos se ≤ 1 foto).
/// - Sem fotos: usa _CoverPlaceholder (gradient amarelo→laranja com
///   ícone de talher), igual ao card da Home — não esconde a área.
class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({super.key, required this.photos});

  final List<Photo> photos;

  static const double height = 280;

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.photos;

    if (photos.isEmpty) {
      return const SizedBox(
        height: PhotoCarousel.height,
        width: double.infinity,
        child: _CoverPlaceholder(),
      );
    }

    return SizedBox(
      height: PhotoCarousel.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: photos.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, index) {
              return CachedNetworkImage(
                imageUrl: photos[index].url,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, _) => Container(
                  color: const Color(0xFFF2F2F2),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                errorWidget: (_, _, _) => const _CoverPlaceholder(),
              );
            },
          ),
          if (photos.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(photos.length, (i) {
                  final active = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 18 : 6,
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
    );
  }
}

/// Mesmo placeholder do card da Home — gradient amarelo→laranja + ícone
/// de talher em branco baixa opacidade. Duplicado aqui porque o do card
/// é privado; futuramente dá pra extrair pra shared/.
class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.warning],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant,
          size: 72,
          color: Colors.white.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}
