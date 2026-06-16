import 'package:flutter/material.dart';
import 'package:food_app_task/core/theme/src/dropdown_theme.dart';
import 'package:food_app_task/core/utils/colors.dart';

import 'src/appbar_theme.dart';
import 'src/bottom_sheet_theme.dart';
import 'src/dialog_theme.dart';
import 'src/divider_theme.dart';
import 'src/elevated_button_theme.dart';
import 'src/icon_theme.dart';
import 'src/input_decoration_theme.dart';
import 'src/outline_button_theme.dart';
import 'src/text_theme.dart';
import 'src/textbuton_theme.dart';

ThemeData dark(BuildContext context) => ThemeData(
  fontFamily: 'Poppins',
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  secondaryHeaderColor: shadowColorDark,

  disabledColor: disabledColorDark,
  scaffoldBackgroundColor: backgroundColorDark,
  hintColor: hintColorDark,
  cardColor: cardColorDark,
  shadowColor: shadowColorDark,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: primaryColor,
    secondary: primaryColor,
    error: error,
    inversePrimary: inversePrimary,
    inverseSurface: inverseSurface,
    onSurface: onSurface,
    onPrimary: onPrimary, //on porimary
  ).copyWith(outline: dividerColorDark, surface: cardColorDark),
  textTheme: textThemeDark(context),
  iconTheme: iconThemeDark(context),
  appBarTheme: appBarThemeDark(context),
  elevatedButtonTheme: elevatedButtonThemeData(context),
  outlinedButtonTheme: outlinedButtonThemeData(context),
  textButtonTheme: textButtonTheme(context),
  inputDecorationTheme: inputDecorationThemeDark(context),
  dropdownMenuTheme: dropdownMenuThemeDark(context),
  dialogTheme: dialogThemeDark(context),
  bottomSheetTheme: bottomSheetThemeDark(context),
  dividerTheme: dividerThemeDark(context),
);
