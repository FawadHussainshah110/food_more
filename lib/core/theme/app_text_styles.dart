import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_app_task/core/theme/app_colors.dart';

/// App text styles for FoodMore using Poppins font
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Poppins';

  // Headers
  static const TextStyle h1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    fontFamily: fontFamily,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  // Labels
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  // Numeric text with tabular figures to avoid jitters
  static const TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle quantity = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // Brand text (logo)
  static const TextStyle brandText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: AppColors.primary,
    fontFamily: fontFamily,
  );
}
