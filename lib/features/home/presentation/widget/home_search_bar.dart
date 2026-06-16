import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:food_app_task/imports.dart';

class HomeSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onTap;

  HomeSearchBarDelegate({required this.onTap});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 48.sp,
          padding: EdgeInsets.symmetric(horizontal: spacingDefault),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(24.sp),
            boxShadow: AppShadows.searchBar,
            border: Border.all(
              color: context.theme.primaryColor.withValues(alpha: 0.1),
              width: 1
            )
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: context.theme.primaryColor,
                size: 20.sp
              ),
              SizedBox(width: spacingMedium),
              Text(
                'Search delicious foods...',
                style: bodyMedium(context).copyWith(
                  color: context.theme.disabledColor
                )
              ),
              const Spacer(),
              Icon(
                Icons.tune_rounded,
                color: context.theme.primaryColor,
                size: 20.sp
              )
            ]
          )
        )
      )
    );
  }

  @override
  double get maxExtent => 64.sp;

  @override
  double get minExtent => 64.sp;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
