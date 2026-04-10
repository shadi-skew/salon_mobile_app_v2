import 'package:flutter/material.dart';

/// Color management class for the application
class ColorManager {
  ColorManager._();

  // Transparent Colors
  static const Color transparent = Colors.transparent;

  // Primary Colors — turquoise & coral palette
  static const Color primary = Color(0xFF34ACB7);
  static const Color primaryDark = Color(0xFF2A8F98);
  static const Color primaryLight = Color(0xFFB9EAEF);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF7A5C);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF616161);
  static const Color veryDarkGrey = Color(0xFF4D4D4D);
  static const Color blackTitle = Color(0xFF0F0F0F);

  // Semantic Colors
  static const Color error = Color(0xFFC00D00);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Design Colors
  static const Color grey = Color(0XFFAAAD99);
  static const Color greyDivider = Color(0xFFCCCCCC);

  // Grey shades
  static const Color grey500 = Color(0XFF4D4D4D);
  static const Color grey200 = Color(0XFFCCCCCC);
  static const Color grey900 = Color(0XFF0F0F0F);
  static Color grey100 = Colors.grey.shade100;

  // Shimmer Loading
  static const Color shimmerGrey = Color(0xFFE5E5E5);

  // Separator
  static const Color separator = Color(0xFFE6E6E6);

  // AI Stylist Colors
  static const Color green = Color(0xFF0F6A6A);
  static const Color background = Color(0xFFF2F2F2);
  static const Color grayText = Color(0xFF6A7282);
  static const Color blackText = Color(0xFF0A0A0A);
  static const Color pink = Color(0xFFFFDCED);
  static const Color darkOrange = Color(0xFFE87156);
  static const Color yellow = Color(0xFFFFFBD5);
}
