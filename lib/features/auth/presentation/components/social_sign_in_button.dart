import 'package:flutter/services.dart';
import 'package:food_app_task/imports.dart';

class SocialSignInButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const SocialSignInButton({super.key, required this.label, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ScaleBounceAnimation(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        height: 40.sp,
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: borderRadiusSmall, boxShadow: AppShadows.cardShadow),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 18.sp, height: 18.sp),
            SizedBox(width: 12.sp),
            Text(label, style: bodyMedium(context)),
          ],
        ),
      ),
    );
  }
}
