import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app_task/imports.dart';
import 'package:food_app_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:food_app_task/features/notifications/presentation/view/notification_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      floating: true,
      pinned: false,
      title: Row(
        children: [
          // Greeting & Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<AuthController>(
                  builder: (auth) {
                    final name = auth.currentUser?.name ?? 'Guest';
                    return Text(
                      'Hey $name, Good Morning! 👋',
                      style: bodySmall(context).copyWith(
                        color: context.theme.hintColor,
                        fontWeight: FontWeight.w500
                      )
                    );
                  }
                ),
                SizedBox(height: spacingExtraSmall),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 16.sp,
                      color: context.theme.primaryColor
                    ),
                    SizedBox(width: spacingExtraSmall),
                    Text(
                      'New York City, USA',
                      style: bodyMedium(context).copyWith(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16.sp,
                      color: context.theme.primaryColor
                    )
                  ]
                )
              ]
            )
          ),
          // Notification Bell
          ScaleBounceAnimation(
            onTap: () {
              launchScreen(const NotificationScreen());
            },
            child: Container(
              padding: paddingSmall,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.cardColor,
                boxShadow: AppShadows.cardShadow
              ),
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: 24.sp,
                    color: bodyMedium(context).color
                  ),
                  Positioned(
                    top: 2.sp,
                    right: 2.sp,
                    child: Container(
                      width: 8.sp,
                      height: 8.sp,
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.error,
                        shape: BoxShape.circle
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}
