import 'package:flutter/material.dart';
import 'package:food_app_task/core/utils/style.dart';

TextButtonThemeData textButtonTheme(BuildContext context) => TextButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    textStyle: bodyMedium(context),
    padding: EdgeInsets.zero,
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
  ),
);
