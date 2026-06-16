import 'package:food_app_task/imports.dart';

DialogThemeData dialogThemeLight(BuildContext context) => DialogThemeData(
  shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
  backgroundColor: backgroundColorLight,
  insetPadding: EdgeInsets.all(30.sp),
);

DialogThemeData dialogThemeDark(BuildContext context) =>
    dialogThemeLight(context).copyWith(backgroundColor: backgroundColorDark);
