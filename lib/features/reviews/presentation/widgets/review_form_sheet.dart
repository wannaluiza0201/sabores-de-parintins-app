import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../establishments/data/models/establishment_mini.dart';
import '../../data/models/review.dart';
import '../../data/providers/review_submission_provider.dart';
import 'star_rating_input.dart';

/// Bottom sheet pra criar OU editar review.
///
/// API:
/// ```dart
/// await ReviewFormSheet.show(context, establishment: e);
/// await ReviewFormSheet.show(context, establishment: e, existingReview: r);
/// ```
class ReviewFormSheet extends ConsumerStatefulWidget {
  const ReviewFormSheet({
    super.key,
    required this.establishment,
    this.existingReview,
  });

  final EstablishmentMini establishment;
  final Review? existingReview;

  static Future<void> show(
    BuildContext context, {
    required EstablishmentMini establishment,
    Review? existingReview,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      // isScrollControlled = true permite o sheet crescer pra acomodar
      // o teclado. Sem isso, o sheet ficaria fixo na altura padrão
      // (~50% da tela) e o teclado cobriria o TextField.
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ReviewFormSheet(
        establishment: establishment,
        existingReview: existingReview,
      ),
    );
  }

  @override
  ConsumerState<ReviewFormSheet> createState() => _ReviewFormSheetState();
}

class _ReviewFormSheetState extends ConsumerState<ReviewFormSheet>
    with TickerProviderStateMixin {
  late int _rating;
  late int _ratingFood;
  late int _ratingService;
  late int _ratingAmbience;
  late final TextEditingController _commentController;

  late final ConfettiController _confetti;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;

  bool _pendingOverlay = false;
  String? _inlineCommentError;

  bool get _isEdit => widget.existingReview != null;
  bool get _canSubmit => _rating > 0;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingReview;
    _rating = existing?.rating ?? 0;
    _ratingFood = existing?.ratingFood ?? 0;
    _ratingService = existing?.ratingService ?? 0;
    _ratingAmbience = existing?.ratingAmbience ?? 0;
    _commentController = TextEditingController(text: existing?.comment ?? '');

    _confetti = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    // Reset do provider compartilhado — garante que um estado antigo
    // (ex: erro de submit anterior) não dispare o ref.listen agora.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(reviewSubmissionProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _confetti.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _setRating(int v) {
    final wasZero = _rating == 0;
    setState(() => _rating = v);
    final reduce = MediaQuery.disableAnimationsOf(context);
    if (!reduce && wasZero && v > 0) {
      _pulseController.forward(from: 0);
    }
  }

  Future<void> _submit() async {
    setState(() => _inlineCommentError = null);

    final comment = _commentController.text.trim();
    final input = ReviewInput(
      rating: _rating,
      // Eixo 0 = "não respondi" → envia null pra API.
      ratingFood: _ratingFood == 0 ? null : _ratingFood,
      ratingService: _ratingService == 0 ? null : _ratingService,
      ratingAmbience: _ratingAmbience == 0 ? null : _ratingAmbience,
      comment: comment.isEmpty ? null : comment,
    );

    await ref.read(reviewSubmissionProvider.notifier).submit(
          slug: widget.establishment.slug,
          input: input,
          existing: widget.existingReview,
        );
  }

  void _handleSubmissionState(ReviewSubmissionState next) {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);

    switch (next) {
      case ReviewSubmissionSuccess():
        final reduce = MediaQuery.disableAnimationsOf(context);
        // Confetti é decorativo — em reduce motion não toca.
        if (!reduce) _confetti.play();
        messenger?.showSnackBar(SnackBar(
          content: Text(l10n.reviewSubmitSuccess),
          behavior: SnackBarBehavior.floating,
        ));
        final closeDelay = reduce
            ? const Duration(milliseconds: 200)
            : const Duration(milliseconds: 1500);
        Future.delayed(closeDelay, () {
          if (mounted) navigator.pop();
        });

      case ReviewSubmissionPending():
        setState(() => _pendingOverlay = true);
        messenger?.showSnackBar(SnackBar(
          content: Text(l10n.reviewSubmitPending),
          behavior: SnackBarBehavior.floating,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) navigator.pop();
        });

      case ReviewSubmissionError(:final duplicated, :final validation, :final message):
        if (duplicated) {
          messenger?.showSnackBar(SnackBar(
            content: Text(l10n.reviewSubmitDuplicate),
            behavior: SnackBarBehavior.floating,
          ));
          navigator.pop();
          return;
        }
        if (validation != null) {
          final commentError = validation.firstErrorFor('comment');
          if (commentError != null) {
            setState(() => _inlineCommentError = commentError);
            return;
          }
        }
        messenger?.showSnackBar(SnackBar(
          content: Text(message ?? l10n.reviewSubmitError),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.danger,
        ));

      case ReviewSubmissionIdle():
      case ReviewSubmissionSubmitting():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ref.listen<ReviewSubmissionState>(
      reviewSubmissionProvider,
      (prev, next) => _handleSubmissionState(next),
    );

    final state = ref.watch(reviewSubmissionProvider);
    final submitting = state is ReviewSubmissionSubmitting;

    return Padding(
      // viewInsets.bottom = altura do teclado. Padding garante que o
      // conteúdo do sheet "sobe" junto com o teclado em vez de ser
      // coberto. Funciona em conjunto com isScrollControlled: true.
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(establishment: widget.establishment),
                  const SizedBox(height: 24),
                  Center(
                    child: StarRatingInput(
                      value: _rating,
                      size: 48,
                      allowZero: true,
                      onChanged: _setRating,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _RatingLabel(rating: _rating),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.reviewFormDetailLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _AxisRow(
                    label: l10n.reviewAxisFood,
                    value: _ratingFood,
                    onChanged: (v) => setState(() => _ratingFood = v),
                  ),
                  _AxisRow(
                    label: l10n.reviewAxisService,
                    value: _ratingService,
                    onChanged: (v) => setState(() => _ratingService = v),
                  ),
                  _AxisRow(
                    label: l10n.reviewAxisAmbience,
                    value: _ratingAmbience,
                    onChanged: (v) => setState(() => _ratingAmbience = v),
                  ),
                  const SizedBox(height: 20),
                  _CommentField(
                    controller: _commentController,
                    errorText: _inlineCommentError,
                    onChanged: () {
                      if (_inlineCommentError != null) {
                        setState(() => _inlineCommentError = null);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ScaleTransition(
                    scale: _pulseScale,
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: _canSubmit && !submitting ? _submit : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                          disabledBackgroundColor:
                              AppColors.primary.withValues(alpha: 0.3),
                          disabledForegroundColor: Colors.black54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: submitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                _isEdit
                                    ? l10n.reviewFormSaveEdits
                                    : l10n.reviewFormSubmit,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Confetti centralizado no topo. BlastDirectionality.explosive
          // espalha partículas em todas as direções (efeito 360°).
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 25,
              maxBlastForce: 18,
              minBlastForce: 8,
              gravity: 0.3,
              colors: const [
                AppColors.primary,
                AppColors.warning,
                AppColors.success,
                Colors.white,
              ],
            ),
          ),

          // Overlay "Em análise" — cobre todo o sheet por 2s antes do pop.
          if (_pendingOverlay)
            Positioned.fill(
              child: ColoredBox(
                color: Colors.white.withValues(alpha: 0.92),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.hourglass_bottom_rounded,
                        size: 64,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.reviewStatusPending,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.reviewPendingOverlayBody,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// Header com foto pequena + nome
// ============================================================

class _Header extends StatelessWidget {
  const _Header({required this.establishment});
  final EstablishmentMini establishment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final url = establishment.coverPhotoUrl;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 48,
            height: 48,
            child: (url == null || url.isEmpty)
                ? const _PhotoPlaceholder()
                : CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (_, _) =>
                        Container(color: const Color(0xFFF2F2F2)),
                    errorWidget: (_, _, _) => const _PhotoPlaceholder(),
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.reviewFormHeaderEyebrow,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                establishment.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.warning],
        ),
      ),
      child: Center(
        child: Icon(Icons.restaurant, size: 24, color: Colors.white70),
      ),
    );
  }
}

// ============================================================
// Label dinâmica (Péssimo/Ruim/Regular/Bom/Ótimo) com transição
// ============================================================

class _RatingLabel extends StatelessWidget {
  const _RatingLabel({required this.rating});
  final int rating;

  String _label(int r, AppLocalizations l10n) {
    switch (r) {
      case 1:
        return l10n.reviewRating1;
      case 2:
        return l10n.reviewRating2;
      case 3:
        return l10n.reviewRating3;
      case 4:
        return l10n.reviewRating4;
      case 5:
        return l10n.reviewRating5;
      default:
        return l10n.reviewRating0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reduce = MediaQuery.disableAnimationsOf(context);
    final isDefault = rating == 0;
    return AnimatedSwitcher(
      duration: reduce ? Duration.zero : const Duration(milliseconds: 200),
      transitionBuilder: (child, anim) {
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.4),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        );
      },
      child: Text(
        _label(rating, l10n),
        key: ValueKey<int>(rating),
        style: TextStyle(
          fontSize: 15,
          fontWeight: isDefault ? FontWeight.w500 : FontWeight.w700,
          color: isDefault ? AppColors.textSecondary : AppColors.textPrimary,
        ),
      ),
    );
  }
}

// ============================================================
// Linha de eixo (label à esquerda + estrelas 32px à direita)
// ============================================================

class _AxisRow extends StatelessWidget {
  const _AxisRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          StarRatingInput(
            value: value,
            size: 28,
            allowZero: true,
            label: label,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TextField de comentário + contador
// ============================================================

class _CommentField extends StatelessWidget {
  const _CommentField({
    required this.controller,
    required this.errorText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String? errorText;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          maxLines: 4,
          maxLength: 1000,
          textInputAction: TextInputAction.newline,
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.reviewFormCommentHint,
            errorText: errorText,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            // Esconde o counter padrão (X / 1000) pra mostrar o nosso
            // estilizado abaixo.
            counterText: '',
          ),
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, _) => Text(
            '${value.text.length} / 1000',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
