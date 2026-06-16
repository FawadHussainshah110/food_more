import 'package:food_app_task/imports.dart';

IconThemeData iconThemeLight(BuildContext context) => IconThemeData(color: iconColorLight, size: 22.sp);

IconThemeData iconThemeDark(BuildContext context) => iconThemeLight(context).copyWith(color: iconColorDark);
