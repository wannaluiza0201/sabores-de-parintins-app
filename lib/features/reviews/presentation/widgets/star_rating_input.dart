import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// Input de estrelas animado e acessível.
///
/// - 5 estrelas em Row.
/// - Tocar na estrela N seleciona valor N (cascata de pulses 1..N).
/// - Se `allowZero` e N == value atual, ZERA (desmarca tudo).
/// - Cada estrela tem seu próprio AnimationController (escala
///   1.0→1.3→1.0 em 250ms elasticOut).
/// - Cor anima de cinza→amarelo via AnimatedSwitcher (fade 200ms).
/// - Cascata: estrelas 1..N animam com `Future.delayed(40ms * i)`.
/// - Haptic SELECTION em cada tap (1 vez, não por estrela).
/// - Respeita `MediaQuery.disableAnimationsOf(context)` — anima
///   instantâneo (Duration.zero) quando reduce motion está ligado.
class StarRatingInput extends StatefulWidget {
  const StarRatingInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 32,
    this.allowZero = false,
    this.label,
  });

  final int value; // 0–5
  final ValueChanged<int> onChanged;
  final double size;
  final bool allowZero;
  final String? label;

  @override
  State<StarRatingInput> createState() => _StarRatingInputState();
}

class _StarRatingInputState extends State<StarRatingInput>
    with TickerProviderStateMixin {
  static const int _starCount = 5;
  static const Duration _cascadeDelay = Duration(milliseconds: 40);
  static const Duration _bumpDuration = Duration(milliseconds: 250);
  static const Color _emptyColor = Color(0xFFE0E0E0);

  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _scales;

  @override
  void initState() {
    super.initState();
    // Um controller por estrela — permite cada estrela animar
    // independente (cascata). TickerProviderStateMixin (não Single...)
    // pra suportar múltiplos controllers no mesmo state.
    _controllers = List.generate(
      _starCount,
      (_) => AnimationController(vsync: this, duration: _bumpDuration),
    );
    // TweenSequence dividida em 2: 0→50% sobe 1.0→1.3, 50→100% volta
    // pra 1.0. elasticOut dá o "bounce" no final.
    _scales = _controllers.map((c) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 1),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.elasticOut));
    }).toList(growable: false);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleTap(int index) {
    final tapped = index + 1; // 1-based
    final newValue = (widget.allowZero && tapped == widget.value) ? 0 : tapped;

    HapticFeedback.selectionClick();
    widget.onChanged(newValue);

    final reduce = MediaQuery.disableAnimationsOf(context);
    if (reduce) return; // sem animação no modo reduce-motion

    // Cascata: anima estrelas 1..maxStar com delay crescente. Se foi
    // pra zero, anima as que ESTAVAM marcadas (efeito de "limpeza").
    final maxStar = newValue == 0 ? widget.value : newValue;
    for (var i = 0; i < maxStar; i++) {
      Future.delayed(_cascadeDelay * i, () {
        if (!mounted) return;
        _controllers[i].forward(from: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reduce = MediaQuery.disableAnimationsOf(context);
    final colorDuration =
        reduce ? Duration.zero : const Duration(milliseconds: 200);

    return Semantics(
      label: widget.label != null
          ? l10n.starsSemanticsLabeled(widget.label!, widget.value, _starCount)
          : l10n.starsSemantics(widget.value, _starCount),
      value: '${widget.value}',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_starCount, (i) {
          final filled = i < widget.value;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _handleTap(i),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size * 0.06),
              child: ScaleTransition(
                scale: _scales[i],
                // AnimatedSwitcher faz fade entre os 2 ícones (vazio
                // outline vs cheio rounded) — daí a "transição suave"
                // de cor pedida no spec. ValueKey força reconstruir.
                child: AnimatedSwitcher(
                  duration: colorDuration,
                  transitionBuilder: (child, anim) =>
                      FadeTransition(opacity: anim, child: child),
                  child: Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    key: ValueKey<bool>(filled),
                    size: widget.size,
                    color: filled ? AppColors.primary : _emptyColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
