import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/models/establishment_detail.dart';

/// Bloco de endereço com ícone, texto e botão "Abrir no Mapa".
///
/// Sem address E sem coords → mostra "Endereço não informado" e
/// o botão desabilitado.
class AddressBlock extends StatelessWidget {
  const AddressBlock({super.key, required this.detail});

  final EstablishmentDetail detail;

  bool get _hasCoords => detail.latitude != 0 && detail.longitude != 0;
  bool get _hasAddress => detail.address.isNotEmpty;
  bool get _enabled => _hasCoords || _hasAddress;

  Future<void> _openMap(BuildContext context) async {
    if (!_enabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.actionLocationMissing),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final Uri uri;
    if (_hasCoords) {
      uri = Uri.parse(
        'geo:${detail.latitude},${detail.longitude}'
        '?q=${detail.latitude},${detail.longitude}'
        '(${Uri.encodeComponent(detail.name)})',
      );
    } else {
      final query = Uri.encodeComponent(
        '${detail.address}, ${detail.neighborhood}',
      );
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$query',
      );
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: _enabled ? AppColors.info : AppColors.textSecondary,
          size: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _hasAddress ? detail.address : l10n.addressNotProvided,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _hasAddress
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontStyle: _hasAddress ? FontStyle.normal : FontStyle.italic,
                ),
              ),
              if (detail.neighborhood.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  detail.neighborhood,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Opacity(
                opacity: _enabled ? 1.0 : 0.5,
                child: TextButton.icon(
                  onPressed: () => _openMap(context),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(Icons.directions, size: 18),
                  label: Text(l10n.addressOpenMap),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
