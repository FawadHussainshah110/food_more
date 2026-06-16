import 'package:flutter/material.dart';
import 'package:food_app_task/core/utils/colors.dart';

DividerThemeData dividerThemeLight(BuildContext context) =>
    const DividerThemeData(thickness: 0.5, color: dividerColorLight, space: 0);

DividerThemeData dividerThemeDark(BuildContext context) => dividerThemeLight(context).copyWith(color: dividerColorDark);
