import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/data/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/login_prompt_dialog.dart';
import '../../data/providers/favorites_provider.dart';

/// Coração de favorito reutilizável.
///
/// Estado é reativo ao `favoritesProvider` — qualquer mudança no
/// Set de IDs (toggle, reconcile, logout) repinta o widget.
class FavoriteButton extends ConsumerStatefulWidget {
  const FavoriteButton({
    super.key,
    required this.establishmentId,
    required this.slug,
    this.size = 24,
    this.inactiveColor,
  });

  final int establishmentId;
  final String slug;
  final double size;
  final Color? inactiveColor;

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    // Duração TOTAL = 200ms (ida + volta).
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // TweenSequence permite encadear "frames-chave":
    //   0%→50%: cresce 1.0 → 1.2
    //   50%→100%: volta 1.2 → 1.0
    // O `weight` é proporcional. 1+1 = metade do tempo pra cada perna.
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    final loggedIn = ref.read(isLoggedInProvider);
    if (!loggedIn) {
      await LoginPromptDialog.show(context);
      return;
    }

    // forward(from: 0) reseta o controller pra 0% e dispara a animação.
    // Sem o `from: 0`, taps rápidos consecutivos começariam do meio.
    _controller.forward(from: 0);
    // Vibração leve — confirma fisicamente o tap (padrão do iFood etc).
    HapticFeedback.lightImpact();

    try {
      await ref
          .read(favoritesProvider.notifier)
          .toggle(widget.establishmentId, widget.slug);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.favoriteToggleError),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isFav = ref.watch(
      favoritesProvider.select((s) => s.contains(widget.establishmentId)),
    );

    return Semantics(
      button: true,
      label: isFav ? l10n.favoriteRemoveSemantics : l10n.favoriteAddSemantics,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: ScaleTransition(
          scale: _scale,
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav
                ? AppColors.danger
                : (widget.inactiveColor ?? AppColors.textSecondary),
            size: widget.size,
          ),
        ),
      ),
    );
  }
}
