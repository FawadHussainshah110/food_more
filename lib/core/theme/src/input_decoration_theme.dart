import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:food_app_task/core/utils/colors.dart';
import 'package:food_app_task/core/utils/style.dart';

InputDecorationTheme inputDecorationThemeLight(BuildContext context) => InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  filled: true,
  fillColor: dividerColorLight,
  contentPadding: paddingDefault,
  // borders
  enabledBorder: border(color: hintColorLight),
  disabledBorder: border(),
  focusedBorder: border(),
  errorBorder: border(color: context.theme.colorScheme.error),
  focusedErrorBorder: border(color: context.theme.colorScheme.error),
  // styles
  errorStyle: bodySmall(context).copyWith(color: context.theme.colorScheme.error),
  hintStyle: bodySmall(context).copyWith(color: hintColorLight),
  labelStyle: bodyMedium(context).copyWith(color: hintColorLight),
);

InputDecorationTheme inputDecorationThemeDark(BuildContext context) => inputDecorationThemeLight(context).copyWith(
  fillColor: cardColorDark,
  hintStyle: bodyMedium(context).copyWith(color: hintColorDark),
  labelStyle: bodyMedium(context).copyWith(color: hintColorDark),
  enabledBorder: border(color: dividerColorDark),
);

InputBorder border({Color? color, bool hideFocusBorder = false}) => OutlineInputBorder(
  borderSide: hideFocusBorder ? BorderSide.none : BorderSide(color: color ?? primaryColor, width: 1.sp),
  borderRadius: borderRadiusSmall,
);
