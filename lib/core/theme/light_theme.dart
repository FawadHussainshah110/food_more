import 'package:flutter/material.dart';
import 'package:food_app_task/core/utils/colors.dart';

import 'src/appbar_theme.dart';
import 'src/bottom_sheet_theme.dart';
import 'src/dialog_theme.dart';
import 'src/divider_theme.dart';
import 'src/dropdown_theme.dart';
import 'src/elevated_button_theme.dart';
import 'src/icon_theme.dart';
import 'src/input_decoration_theme.dart';
import 'src/outline_button_theme.dart';
import 'src/text_theme.dart';
import 'src/textbuton_theme.dart';

ThemeData light(BuildContext context) => ThemeData(
  fontFamily: 'Poppins',
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  disabledColor: disabledColorLight,
  scaffoldBackgroundColor: backgroundColorLight,
  hintColor: hintColorLight,
  cardColor: cardColorLight,
  shadowColor: shadowColorLight, //shadowColorLight
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    secondary: const Color.fromRGBO(5, 154, 252, 1),
    error: error,
    inversePrimary: inversePrimary,
    inverseSurface: inverseSurface,
    onPrimary: onPrimary, //on porimary
    onSurface: onSurface,
  ).copyWith(outline: dividerColorLight),
  textTheme: textThemeLight(context),
  iconTheme: iconThemeLight(context),
  appBarTheme: appBarThemeLight(context),
  elevatedButtonTheme: elevatedButtonThemeData(context),
  outlinedButtonTheme: outlinedButtonThemeData(context),
  textButtonTheme: textButtonTheme(context),
  inputDecorationTheme: inputDecorationThemeLight(context),
  dropdownMenuTheme: dropdownMenuThemeLight(context),
  dialogTheme: dialogThemeLight(context),
  bottomSheetTheme: bottomSheetThemeLight(context),
  dividerTheme: dividerThemeLight(context),
);
