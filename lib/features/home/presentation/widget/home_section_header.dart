import 'package:flutter/material.dart';
import 'package:food_app_task/imports.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const HomeSectionHeader({
    Key? key,
    required this.title,
    this.onSeeAll
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bodyLarge(context).copyWith(
              fontWeight: FontWeight.bold
            )
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: bodySmall(context).copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16.sp,
                    color: context.theme.primaryColor
                  )
                ]
              )
            )
        ]
      )
    );
  }
}
