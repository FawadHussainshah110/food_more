import 'package:food_app_task/imports.dart';

AppBarTheme appBarThemeLight(BuildContext context) => AppBarTheme(
  elevation: 0,
  scrolledUnderElevation: 0,
  titleSpacing: 16.sp,
  backgroundColor: backgroundColorLight,
  surfaceTintColor: backgroundColorLight,
  shadowColor: backgroundColorLight,
  titleTextStyle: TextStyle(fontFamily: 'Poppins', color: textColorLight, fontSize: 18.sp, fontWeight: FontWeight.w600),
  centerTitle: true,
  iconTheme: const IconThemeData(color: textColorLight),
);

AppBarTheme appBarThemeDark(BuildContext context) => appBarThemeLight(context).copyWith(
  backgroundColor: backgroundColorDark,
  surfaceTintColor: backgroundColorDark,
  shadowColor: backgroundColorDark,
  titleTextStyle: TextStyle(fontFamily: 'Poppins', color: textColorDark, fontSize: 18.sp, fontWeight: FontWeight.w600),
  iconTheme: const IconThemeData(color: textColorDark),
);
