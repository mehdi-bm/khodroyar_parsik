import 'package:flutter/material.dart';

/// Centralized brand colors for خودرویار. Never hard-code colors in widgets —
/// reference these (or [AppSemanticColors] via the theme) instead.
abstract final class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF0EA5E9);

  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color darkBackground = Color(0xFF101114);

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF1A1B1F);

  static const Color success = Color(0xFF16A34A);
  static const Color successDark = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFD97706);
  static const Color warningDark = Color(0xFFFBBF24);
}

/// Status semantics used across maintenance, documents, and reports —
/// success/warning are not part of Material's [ColorScheme], so they're
/// exposed as a [ThemeExtension] to stay theme-aware (light/dark) and
/// centrally defined per the app's accessibility rule: never rely on color
/// alone, but the color itself must still come from one place.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({required this.success, required this.warning});

  final Color success;
  final Color warning;

  static const light = AppSemanticColors(
    success: AppColors.success,
    warning: AppColors.warning,
  );

  static const dark = AppSemanticColors(
    success: AppColors.successDark,
    warning: AppColors.warningDark,
  );

  @override
  AppSemanticColors copyWith({Color? success, Color? warning}) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
