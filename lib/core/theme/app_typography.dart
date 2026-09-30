import 'package:flutter/material.dart';

/// Persian-friendly type scale built on Vazirmatn. Keep font sizes generous
/// enough to stay legible on small Android screens per the app's UI rules.
abstract final class AppTypography {
  static const String fontFamily = 'Vazirmatn';

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: _style(32, FontWeight.w700, color),
      displayMedium: _style(28, FontWeight.w700, color),
      displaySmall: _style(26, FontWeight.w700, color),
      headlineLarge: _style(24, FontWeight.w700, color),
      headlineMedium: _style(20, FontWeight.w600, color),
      headlineSmall: _style(19, FontWeight.w600, color),
      titleLarge: _style(18, FontWeight.w600, color),
      titleMedium: _style(16, FontWeight.w600, color),
      titleSmall: _style(14, FontWeight.w600, color),
      bodyLarge: _style(16, FontWeight.w400, color),
      bodyMedium: _style(14, FontWeight.w400, color),
      bodySmall: _style(12, FontWeight.w400, color),
      labelLarge: _style(14, FontWeight.w500, color),
      labelMedium: _style(12, FontWeight.w500, color),
      labelSmall: _style(11, FontWeight.w500, color),
    );
  }

  static TextStyle _style(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.5,
      letterSpacing: 0,
    );
  }
}
