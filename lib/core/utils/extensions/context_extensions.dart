import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen width
  double get screenWidth => mediaQuery.size.width;

  /// Get screen height
  double get screenHeight => mediaQuery.size.height;

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;
}
