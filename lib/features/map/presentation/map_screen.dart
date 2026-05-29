import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../establishments/data/models/establishment.dart';
import '../../establishments/data/providers/establishment_providers.dart';
import '../../establishments/data/providers/map_establishments_provider.dart';
import 'widgets/establishment_marker.dart';
import 'widgets/locate_me_button.dart';
import 'widgets/map_bottom_card.dart';

/// Tela de Mapa — flutter_map + OSM tiles, marcadores por estabelecimento.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  // MapController controla o mapa imperativamente (mover, dar zoom).
  // setState não basta porque o widget MapOptions só usa `initialCenter`
  // no primeiro frame — depois o controller é a única via.
  final _mapController = MapController();

  // Centro inicial: Parintins (-2.6283, -56.7356).
  static const _parintins = LatLng(-2.6283, -56.7356);

  // Estabelecimento selecionado (mostra o card flutuante). null = nenhum.
  Establishment? _selected;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _onMarkerTap(Establishment item) {
    setState(() => _selected = item);
  }

  void _dismissCard() {
    setState(() => _selected = null);
  }

  @override
  Widget build(BuildContext context) {
    final establishmentsAsync = ref.watch(establishmentsProvider);
    final mapItems = ref.watch(mapEstablishmentsProvider);
    final userPos = ref.watch(userLocationProvider);
    final totalCount = establishmentsAsync.value?.length ?? 0;

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // tab interno, sem botão voltar
        title: Text(
          l10n.navMap,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: establishmentsAsync.when(
        loading: () => const _MapLoading(),
        error: (err, _) => _MapError(message: '$err'),
        data: (_) => _buildMap(mapItems, userPos, totalCount),
      ),
    );
  }

  Widget _buildMap(
    List<Establishment> mapItems,
    dynamic userPos,
    int totalCount,
  ) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: _parintins,
            initialZoom: 13.5,
            minZoom: 11,
            maxZoom: 18,
            // Rotação desligada — UX mais previsível pro nosso caso.
            // Pinch zoom e arraste continuam ativos por padrão.
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.doubleTapZoom |
                  InteractiveFlag.scrollWheelZoom,
            ),
            // Cinza claro enquanto tiles carregam (em vez de tela branca).
            backgroundColor: Color(0xFFE6E6E6),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              // userAgent obrigatório pra usar OSM educadamente.
              userAgentPackageName:
                  'br.com.sebrae.parintins.sabores_parintins_app',
              maxZoom: 19,
            ),
            // Marcador do usuário (se localização ativa).
            if (userPos != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(userPos.latitude, userPos.longitude),
                    width: 20,
                    height: 20,
                    child: const _UserDot(),
                  ),
                ],
              ),
            // Marcadores dos estabelecimentos.
            MarkerLayer(
              markers: mapItems
                  .map(
                    (e) => Marker(
                      point: LatLng(e.latitude, e.longitude),
                      width: EstablishmentMarkerWidget.width,
                      height: EstablishmentMarkerWidget.height,
                      // alignment.bottomCenter faz a "ponta" do pino
                      // apontar pra coordenada exata.
                      alignment: Alignment.bottomCenter,
                      child: EstablishmentMarkerWidget(
                        categoryIcon: e.primaryCategory.icon,
                        isOpen: e.isOpenNow,
                        onTap: () => _onMarkerTap(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),

        // Counter + Attribution canto inferior esquerdo.
        Positioned(
          left: 8,
          bottom: 8 + (_selected != null ? MapBottomCard.height : 0),
          child: _MapFootnote(shown: mapItems.length, total: totalCount),
        ),

        // FAB localização — canto inferior direito, sobe se card visível.
        Positioned(
          right: 16,
          bottom: 16 + (_selected != null ? MapBottomCard.height : 0),
          child: LocateMeButton(
            onLocated: (pos) {
              _mapController.move(LatLng(pos.latitude, pos.longitude), 15);
            },
          ),
        ),

        // Card flutuante — AnimatedSlide entra de baixo.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            offset: _selected == null ? const Offset(0, 1) : Offset.zero,
            // IgnorePointer evita que o card "fantasma" (offset=1) capture
            // gestos enquanto está fora da tela.
            child: IgnorePointer(
              ignoring: _selected == null,
              child: _selected == null
                  ? const SizedBox(height: MapBottomCard.height)
                  : MapBottomCard(
                      item: _selected!,
                      userPosition: userPos,
                      onClose: _dismissCard,
                    ),
            ),
          ),
        ),

        // Empty state se não há nenhum estabelecimento com coords.
        if (mapItems.isEmpty)
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    AppLocalizations.of(context)!.mapNoLocations,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// Sub-widgets
// ============================================================

/// Pontinho azul "você está aqui". Marker (não CircleMarker) — não
/// muda de tamanho com zoom; é um widget fixo.
class _UserDot extends StatelessWidget {
  const _UserDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.info,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.info.withValues(alpha: 0.4),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class _MapFootnote extends StatelessWidget {
  const _MapFootnote({required this.shown, required this.total});
  final int shown;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.mapShowingCount(shown, total),
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            '© OpenStreetMap contributors',
            style: TextStyle(fontSize: 9, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _MapLoading extends StatelessWidget {
  const _MapLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _MapError extends StatelessWidget {
  const _MapError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: AppColors.danger),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.homeEstablishmentsError,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
