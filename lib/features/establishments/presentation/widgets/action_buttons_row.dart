import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/models/establishment_detail.dart';
import 'disabled_action_button.dart';

/// Linha dos 4 botões de ação: WhatsApp, Instagram, Mapa, Compartilhar.
///
/// Cada botão decide sozinho se está habilitado a partir dos campos do
/// `EstablishmentDetail`. Quando desabilitado, o DisabledActionButton já
/// mostra SnackBar explicando o motivo — não precisa de lógica extra aqui.
class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key, required this.detail});

  final EstablishmentDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DisabledActionButton(
          icon: Icons.chat,
          label: l10n.actionWhatsApp,
          isEnabled: _hasWhatsApp(detail),
          enabledColor: const Color(0xFF25D366),
          disabledMessage: l10n.actionWhatsAppMissing,
          onPressed: () => _openWhatsApp(context, detail),
        ),
        DisabledActionButton(
          icon: Icons.camera_alt,
          label: l10n.actionInstagram,
          isEnabled: detail.instagramUrl?.isNotEmpty ?? false,
          enabledColor: const Color(0xFFE1306C),
          disabledMessage: l10n.actionInstagramMissing,
          onPressed: () => _openUrl(context, detail.instagramUrl!),
        ),
        DisabledActionButton(
          icon: Icons.map,
          label: l10n.actionMap,
          isEnabled: _hasMap(detail),
          enabledColor: AppColors.info,
          disabledMessage: l10n.actionLocationMissing,
          onPressed: () => _openMap(context, detail),
        ),
        DisabledActionButton(
          icon: Icons.share,
          label: l10n.actionShare,
          isEnabled: true,
          enabledColor: const Color(0xFF757575),
          disabledMessage: '',
          onPressed: () => _share(context, detail),
        ),
      ],
    );
  }

  // ============================================================
  // Decisões de habilitação
  // ============================================================

  bool _hasWhatsApp(EstablishmentDetail d) {
    // A API já fornece whatsapp_url pronto. Como fallback (estabelecimento
    // que só preencheu telefone), montamos a partir do phone sanitizado.
    if (d.whatsappUrl != null && d.whatsappUrl!.isNotEmpty) return true;
    return _digitsOnly(d.phone ?? '').length >= 10;
  }

  bool _hasMap(EstablishmentDetail d) {
    final hasCoords = d.latitude != 0 && d.longitude != 0;
    return hasCoords || d.address.isNotEmpty;
  }

  // ============================================================
  // Ações
  // ============================================================

  /// Abre URL com fallback gracioso:
  /// - `platformDefault` deixa o sistema decidir: se há app dedicado
  ///   (WhatsApp, Instagram) abre nele; senão abre no navegador.
  ///   Mais robusto que `externalApplication` em emulador, que falha
  ///   quando o app dedicado não está instalado.
  /// - try/catch: launchUrl pode lançar exception (URI inválido, sem
  ///   app pra abrir, etc.). Mostramos no SnackBar pra debug visível
  ///   em vez de falhar em silêncio.
  Future<void> _openUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
      if (!ok && context.mounted) {
        _showError(
          context,
          AppLocalizations.of(context)!.actionOpenUrlError(url),
        );
      }
    } catch (e) {
      debugPrint('launchUrl falhou: $e');
      if (context.mounted) {
        _showError(
          context,
          AppLocalizations.of(context)!.actionGenericError(e.toString()),
        );
      }
    }
  }

  Future<void> _openWhatsApp(
    BuildContext context,
    EstablishmentDetail d,
  ) async {
    final waUrl = d.whatsappUrl;
    final url = (waUrl != null && waUrl.isNotEmpty)
        ? waUrl
        : 'https://wa.me/55${_digitsOnly(d.phone ?? '')}';
    final greeting = Uri.encodeComponent(
      AppLocalizations.of(context)!.actionWhatsAppGreeting,
    );
    await _openUrl(context, '$url?text=$greeting');
  }

  /// Mapa: tenta `geo:` (Maps/Waze nativos do Android) PRIMEIRO. Se não
  /// houver app que resolva — caso típico no emulador, que vem sem
  /// Google Maps — cai pro Maps Web no navegador.
  Future<void> _openMap(BuildContext context, EstablishmentDetail d) async {
    final hasCoords = d.latitude != 0 && d.longitude != 0;

    if (hasCoords) {
      final geoUri = Uri.parse(
        'geo:${d.latitude},${d.longitude}?q=${d.latitude},${d.longitude}'
        '(${Uri.encodeComponent(d.name)})',
      );
      try {
        if (await canLaunchUrl(geoUri)) {
          final ok = await launchUrl(geoUri);
          if (ok) return;
        }
      } catch (_) {
        // ignora — vai pro fallback abaixo
      }
      // Fallback: Maps Web. context.mounted é assíncrono-seguro.
      if (!context.mounted) return;
      await _openUrl(
        context,
        'https://www.google.com/maps/search/?api=1&query=${d.latitude},${d.longitude}',
      );
      return;
    }

    final query = Uri.encodeComponent('${d.address}, ${d.neighborhood}');
    await _openUrl(
      context,
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
  }

  Future<void> _share(BuildContext context, EstablishmentDetail d) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final text = StringBuffer()..writeln(l10n.actionShareText(d.name));
      if (d.address.isNotEmpty) text.writeln(d.address);
      final desc = d.description;
      if (desc != null && desc.isNotEmpty) text.writeln(desc);
      await SharePlus.instance.share(ShareParams(text: text.toString().trim()));
    } catch (e) {
      debugPrint('share falhou: $e');
      if (context.mounted) {
        _showError(context, l10n.actionShareError(e.toString()));
      }
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _digitsOnly(String s) => s.replaceAll(RegExp(r'\D'), '');
}
