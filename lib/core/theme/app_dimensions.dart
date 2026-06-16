import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// App dimensions and spacing constants scaled with ScreenUtil .sp
class AppDimensions {
  AppDimensions._();

  // Padding & Margin
  static double get screenHorizontal => 24.sp;
  static double get cardPadding => 12.sp;
  static double get inputPadding => 16.sp;

  // Gaps
  static double get spacingExtraSmall => 4.sp;
  static double get spacingSmall => 8.sp;
  static double get spacingMedium => 12.sp;
  static double get spacingDefault => 16.sp;
  static double get spacingLarge => 24.sp;
  static double get spacingExtraLarge => 32.sp;

  // Border Radius
  static double get radiusSmall => 8.sp;
  static double get radiusMedium => 12.sp;
  static double get radiusLarge => 16.sp;
  static double get radiusFull => 30.sp;

  // Component Sizes
  static double get logoSize => 32.sp;
  static double get menuIconSize => 24.sp;
  static double get foodCardWidth => 160.sp;
  static double get foodCardHeight => 220.sp;
  static double get restaurantCardHeight => 200.sp;
  static double get bottomNavHeight => 75.sp;
  static double get searchBarHeight => 50.sp;
}
