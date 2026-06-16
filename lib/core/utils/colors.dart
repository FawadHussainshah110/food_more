import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color primaryColor = Color(0xFF6C3BFF); // Electric Purple
const Color secondaryColor = Color(0xFFFF6B4A); // Coral Orange
const Color accentColor = Color(0xFF32D7A6); // Mint Green

// Background colors
const Color backgroundColorLight = Color(0xFFF8F9FC);
const Color backgroundColorDark = Color(0xFF0F1117);

// Card colors
const Color cardColorLight = Color(0xFFFFFFFF);
const Color cardColorDark = Color(0xFF1A1B23);

const Color transparent = Colors.transparent;

// Shadow colors
const Color shadowColorLight = Color(0x0F000000);
const Color shadowColorDark = Color(0x4D000000);

// Divider colors
const Color dividerColorLight = Color(0xFFE2E8F0);
const Color dividerColorDark = Color(0xFF2E2F3E);

// Disabled colors
const Color disabledColorLight = Color(0xFFCBD5E1);
const Color disabledColorDark = Color(0xFF475569);

// Hint colors
const Color hintColorLight = Color(0xFF94A3B8);
const Color hintColorDark = Color(0xFF64748B);

// Text colors
const Color textColorLight = Color(0xFF0F1117);
const Color textColorDark = Color(0xFFFFFFFF);

// Icon colors
const Color iconColorLight = Color(0xFF64748B);
const Color iconColorDark = Color(0xFF94A3B8);

const Color onPrimary = Colors.white;
const Color onSurface = Color(0xFF0F1117);

// Indicators
const Color pickupIndicatorColor = Color(0xFF32D7A6); // Mint Green
const Color dropoffIndicatorColor = Color(0xFFFF6B4A); // Coral Orange
const Color stop1IndicatorColor = Color(0xFFFB923C);
const Color stop2IndicatorColor = Color(0xFFA78BFA);
const Color stop3IndicatorColor = Color(0xFFF472B6);
const Color mapLocationColor = Color(0xFF6C3BFF);

const Color error = Color(0xFFEF4444);
const Color inverseSurface = Color(0xFFFFE661);
const Color inversePrimary = Color(0xFF32D7A6);

// Gradients
LinearGradient get primaryGradientTopRightBottom => const LinearGradient(
      colors: [primaryColor, secondaryColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

LinearGradient get primaryGradientRightBottom => LinearGradient(
      colors: [primaryColor.withOpacity(0.8), secondaryColor.withOpacity(0.1)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

LinearGradient get buttonGradient => const LinearGradient(
      colors: [primaryColor, secondaryColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

List<BoxShadow>? get boxShadow => [
      BoxShadow(
        color: Get.theme.shadowColor.withOpacity(0.04),
        blurRadius: 10,
        offset: const Offset(0, 4),
      )
    ];
