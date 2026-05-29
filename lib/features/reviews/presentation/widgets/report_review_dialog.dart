import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/data/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/login_prompt_dialog.dart';
import '../../data/models/review.dart';
import '../../data/providers/report_submission_provider.dart';

/// Diálogo de denúncia. Anônimo cai no LoginPromptDialog antes.
///
/// API estável:
/// ```dart
/// await ReportReviewDialog.show(context, reviewId: id);
/// ```
class ReportReviewDialog extends ConsumerStatefulWidget {
  const ReportReviewDialog({super.key, required this.reviewId});

  final int reviewId;

  /// Faz check de login ANTES de abrir o dialog. Se anônimo, abre
  /// LoginPromptDialog (mesmo padrão do FavoriteButton).
  static Future<void> show(
    BuildContext context, {
    required int reviewId,
  }) async {
    // ProviderScope.containerOf(context) dá acesso ao container do
    // Riverpod sem precisar de WidgetRef — usável em métodos estáticos.
    final container = ProviderScope.containerOf(context);
    final loggedIn = container.read(isLoggedInProvider);
    if (!loggedIn) {
      await LoginPromptDialog.show(context);
      return;
    }
    if (!context.mounted) return;
    return showDialog<void>(
      context: context,
      builder: (_) => ReportReviewDialog(reviewId: reviewId),
    );
  }

  @override
  ConsumerState<ReportReviewDialog> createState() =>
      _ReportReviewDialogState();
}

class _ReportReviewDialogState extends ConsumerState<ReportReviewDialog> {
  ReportReason? _selectedReason;
  final _notesController = TextEditingController();
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    // Reset do provider antes de abrir — evita disparar listen com
    // um Success/Error de uma denúncia anterior.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(reportSubmissionProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    if (_selectedReason == null) return false;
    // "Outro" exige um texto explicativo — orienta UX e ajuda
    // moderação a entender o motivo.
    if (_selectedReason == ReportReason.other &&
        _notesController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _submit() async {
    final reason = _selectedReason;
    if (reason == null) return;
    final notes = _notesController.text.trim();
    await ref.read(reportSubmissionProvider.notifier).submit(
          reviewId: widget.reviewId,
          input: ReportInput(
            reason: reason,
            notes: notes.isEmpty ? null : notes,
          ),
        );
  }

  void _handleState(ReportSubmissionState next) {
    final l10n = AppLocalizations.of(context)!;
    switch (next) {
      case ReportSubmissionSuccess():
        setState(() => _showSuccess = true);
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) Navigator.of(context).pop();
        });
      case ReportSubmissionError(:final message):
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Text(message ?? l10n.reportError),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.danger,
          ),
        );
      case ReportSubmissionIdle():
      case ReportSubmissionSubmitting():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ref.listen<ReportSubmissionState>(
      reportSubmissionProvider,
      (prev, next) => _handleState(next),
    );

    final state = ref.watch(reportSubmissionProvider);
    final submitting = state is ReportSubmissionSubmitting;

    if (_showSuccess) {
      return const _SuccessDialog();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        l10n.reportTitle,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
      content: SizedBox(
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  l10n.reportPrompt,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // RadioGroup ancestor gerencia groupValue/onChanged
              // centralmente (Flutter 3.32+ depreciou os props nas tiles).
              RadioGroup<ReportReason>(
                groupValue: _selectedReason,
                onChanged: (v) {
                  if (submitting) return;
                  setState(() => _selectedReason = v);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final reason in ReportReason.values)
                      RadioListTile<ReportReason>(
                        value: reason,
                        dense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        activeColor: AppColors.primary,
                        title: Text(
                          reason.label,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
              // TextField só aparece se "Outro" — AnimatedSize suaviza
              // a entrada/saída do campo.
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: _selectedReason == ReportReason.other
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                        child: TextField(
                          controller: _notesController,
                          enabled: !submitting,
                          maxLines: 3,
                          maxLength: 500,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: l10n.reportNotesHint,
                            border: const OutlineInputBorder(),
                            counterText: '',
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              submitting ? null : () => Navigator.of(context).pop(),
          child: Text(
            l10n.commonCancel,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        FilledButton(
          onPressed: (_canSubmit && !submitting) ? _submit : null,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.danger,
            foregroundColor: Colors.white,
          ),
          child: submitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(l10n.reportSubmit),
        ),
      ],
    );
  }
}

// ============================================================
// Conteúdo do dialog após sucesso (check animado)
// ============================================================

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reduce = MediaQuery.disableAnimationsOf(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SizedBox(
        width: 280,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: reduce
                    ? Duration.zero
                    : const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                builder: (_, value, _) => Transform.scale(
                  scale: value,
                  child: const Icon(
                    Icons.check_circle,
                    size: 72,
                    color: AppColors.success,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.reportSuccessTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.reportSuccessBody,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
