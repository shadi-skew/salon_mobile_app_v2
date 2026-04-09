import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/core/resources/font_manager.dart';

/// Typography System
class TextStyles {
  TextStyles._();

  // ========================================
  // TITLE STYLES
  // ========================================

  static TextStyle title1({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? FontFamilyManager.defaultFont,
      fontSize: fontSize ?? FontSizesManager.s32,
      fontWeight: fontWeight ?? FontWeightManager.regular,
      color: color ?? ColorManager.blackTitle,
    );
  }

  static TextStyle title2({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? FontFamilyManager.defaultFont,
      fontSize: fontSize ?? FontSizesManager.s24,
      fontWeight: fontWeight ?? FontWeightManager.semiBold,
      color: color ?? ColorManager.blackTitle,
    );
  }

  static TextStyle title3({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? FontFamilyManager.defaultFont,
      fontWeight: fontWeight ?? FontWeightManager.semiBold,
      fontSize: fontSize ?? FontSizesManager.s20,
      color: color ?? ColorManager.blackTitle,
    );
  }

  // ========================================
  // BODY STYLES
  // ========================================

  static TextStyle body1({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? FontFamilyManager.defaultFont,
      fontSize: fontSize ?? FontSizesManager.s16,
      fontWeight: fontWeight ?? FontWeightManager.regular,
      color: color ?? ColorManager.blackTitle,
    );
  }

  static TextStyle body2({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? FontFamilyManager.defaultFont,
      fontSize: fontSize ?? FontSizesManager.s14,
      fontWeight: fontWeight ?? FontWeightManager.regular,
      color: color ?? ColorManager.blackTitle,
    );
  }

  static TextStyle caption({
    Color? color,
    String? fontFamily,
    double? size,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? FontFamilyManager.defaultFont,
      fontSize: size ?? FontSizesManager.s12,
      fontWeight: fontWeight ?? FontWeightManager.regular,
      color: color ?? ColorManager.blackTitle,
    );
  }
}
