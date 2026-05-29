import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Cores da marca que não cabem no ColorScheme padrão do Material 3.
/// Acesso: `Theme.of(context).extension<BrandColors>()!`
@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors({required this.warning, required this.success});

  final Color warning;
  final Color success;

  @override
  BrandColors copyWith({Color? warning, Color? success}) => BrandColors(
    warning: warning ?? this.warning,
    success: success ?? this.success,
  );

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      warning: Color.lerp(warning, other.warning, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: Colors.black,
          secondary: AppColors.info,
          onSecondary: Colors.white,
          tertiary: AppColors.success,
          onTertiary: Colors.white,
          error: AppColors.danger,
          onError: Colors.white,
        );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.white,
      textTheme: AppTextStyles.build(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        BrandColors(warning: AppColors.warning, success: AppColors.success),
      ],
    );
  }
}
