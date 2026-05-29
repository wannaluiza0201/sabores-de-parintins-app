import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/services/location_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../establishments/data/providers/map_establishments_provider.dart';

/// FAB de "minha localização" — fluxo completo:
/// 1. Verifica permissão atual.
/// 2. Se ainda não pediu, mostra dialog explicativo customizado.
/// 3. Pede permissão nativa do SO.
/// 4. Se concedida, busca a posição e chama `onLocated(position)` pra
///    a tela animar o mapa.
/// 5. Se negada pra sempre, snackbar com botão "Abrir Configurações".
class LocateMeButton extends ConsumerStatefulWidget {
  const LocateMeButton({super.key, required this.onLocated});

  /// Callback chamado quando obtemos a posição com sucesso. A MapScreen
  /// usa pra mover o MapController e setar o userLocationProvider.
  final void Function(Position position) onLocated;

  @override
  ConsumerState<LocateMeButton> createState() => _LocateMeButtonState();
}

class _LocateMeButtonState extends ConsumerState<LocateMeButton> {
  final _service = const LocationService();
  bool _loading = false;

  Future<void> _onTap() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      final status = await _service.checkPermission();

      if (status == LocationPermissionStatus.serviceDisabled) {
        if (mounted) {
          _snack(AppLocalizations.of(context)!.locationGpsDisabled);
        }
        return;
      }

      if (status == LocationPermissionStatus.deniedForever) {
        if (mounted) _snackOpenSettings();
        return;
      }

      // Não pediu ainda (denied default): mostra rationale antes do
      // dialog nativo. Conceito: usuários respondem melhor quando
      // entendem o "por quê" antes do prompt do sistema.
      if (status == LocationPermissionStatus.denied) {
        final accepted = await _showRationaleDialog();
        if (accepted != true) return;
        final after = await _service.requestPermission();
        if (after != LocationPermissionStatus.granted) {
          if (after == LocationPermissionStatus.deniedForever && mounted) {
            _snackOpenSettings();
          }
          return;
        }
      }

      // Permissão OK — busca a posição.
      final pos = await _service.getCurrentPosition();
      if (pos == null) {
        if (mounted) {
          _snack(AppLocalizations.of(context)!.locationFailed);
        }
        return;
      }
      ref.read(userLocationProvider.notifier).set(pos);
      widget.onLocated(pos);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<bool?> _showRationaleDialog() {
    return showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx)!;
        return AlertDialog(
          title: Text(l10n.locationDialogTitle),
          content: Text(l10n.locationDialogBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.commonNotNow),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.commonAllow),
            ),
          ],
        );
      },
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _snackOpenSettings() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.locationDeniedForever),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: l10n.commonOpen,
          onPressed: openAppSettings,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLocation = ref.watch(userLocationProvider) != null;
    return FloatingActionButton(
      heroTag: 'locate-me',
      onPressed: _onTap,
      backgroundColor: Colors.white,
      elevation: 4,
      child: _loading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            )
          : Icon(
              hasLocation ? Icons.gps_fixed : Icons.my_location,
              color: AppColors.primary,
            ),
    );
  }
}
