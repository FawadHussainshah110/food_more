import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:food_app_task/core/theme/app_colors.dart';

/// App shadow styles for premium UI feel
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      offset: Offset(0, 8.sp),
      blurRadius: 16.sp,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.25),
      offset: Offset(0, 4.sp),
      blurRadius: 12.sp,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get bottomNav => [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: Offset(0, -4.sp),
      blurRadius: 16.sp,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get searchBar => [
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      offset: Offset(0, 4.sp),
      blurRadius: 12.sp,
      spreadRadius: 0,
    ),
  ];
}
