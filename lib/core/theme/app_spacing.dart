import 'package:flutter/widgets.dart';

/// Centralized spacing scale — reference these instead of magic numbers.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Standard scrollable-page padding, extended at the bottom by the
  /// device's own safe-area inset (3-button nav bar / gesture handle) so
  /// the last piece of content — often a submit button — never ends up
  /// rendered behind it.
  static EdgeInsets page(BuildContext context) => EdgeInsets.fromLTRB(
    lg,
    lg,
    lg,
    lg + MediaQuery.paddingOf(context).bottom,
  );
}

/// Centralized corner radii for cards, buttons, inputs, and dialogs.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}
