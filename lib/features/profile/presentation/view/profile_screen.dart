import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app_task/imports.dart';
import 'package:food_app_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:food_app_task/features/theme/presentation/controller/theme_controller.dart';
import 'package:food_app_task/features/auth/presentation/view/login_screen.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: paddingDefault,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusLarge,
          boxShadow: AppShadows.cardShadow
        ),
        child: Row(
          children: [
            Icon(icon, color: context.theme.primaryColor, size: 22.sp),
            SizedBox(width: spacingDefault),
            Text(
              title,
              style: bodyMedium(context).copyWith(
                fontWeight: FontWeight.bold
              )
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: context.theme.disabledColor,
              size: 16.sp
            )
          ]
        )
      )
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void handleLogout() {
    showConfirmationDialog(
      title: 'Sign Out',
      subtitle: 'Are you sure you want to sign out of your account?',
      actionText: 'Sign Out',
      onAccept: () {
        pop();
        AuthController.find.logout();
        launchScreen(const LoginScreen(), pushAndRemove: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingDefault),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: spacingLarge),
              // User details avatar
              GetBuilder<AuthController>(
                builder: (auth) {
                  final url = auth.currentUser?.photoUrl ?? Images.profileplaceholder;
                  final name = auth.currentUser?.name ?? 'Guest User';
                  final email = auth.currentUser?.email ?? 'guest@example.com';

                  return Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.sp,
                          backgroundImage: NetworkImage(url)
                        ),
                        SizedBox(height: spacingDefault),
                        Text(
                          name,
                          style: titleMedium(context).copyWith(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: spacingExtraSmall),
                        Text(
                          email,
                          style: bodyMedium(context).copyWith(
                            fontSize: 13.sp,
                            color: context.theme.hintColor
                          )
                        )
                      ]
                    )
                  );
                }
              ),
              SizedBox(height: spacingExtraLarge),

              // Settings Items
              Text(
                'Account Settings',
                style: bodyLarge(context).copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: spacingDefault),

              // Theme Mode Toggle
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacingDefault,
                  vertical: spacingMedium
                ),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: borderRadiusLarge,
                  boxShadow: AppShadows.cardShadow
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: context.theme.primaryColor,
                          size: 22.sp
                        ),
                        SizedBox(width: spacingDefault),
                        Text(
                          'Dark Mode',
                          style: bodyMedium(context).copyWith(
                            fontWeight: FontWeight.bold
                          )
                        )
                      ]
                    ),
                    GetBuilder<ThemeController>(
                      builder: (theme) {
                        final isDark = theme.themeMode == ThemeMode.dark;
                        return Switch(
                          value: isDark,
                          activeThumbColor: context.theme.primaryColor,
                          onChanged: (val) {
                            theme.setThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                          }
                        );
                      }
                    )
                  ]
                )
              ),
              SizedBox(height: spacingMedium),

              // Saved Addresses
              MenuTile(
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                onTap: () {
                  showCustomSnackBar('Saved Addresses coming soon!');
                }
              ),
              SizedBox(height: spacingMedium),

              // Payments
              MenuTile(
                icon: Icons.credit_card_rounded,
                title: 'Payment Methods',
                onTap: () {
                  showCustomSnackBar('Payment Methods coming soon!');
                }
              ),
              SizedBox(height: spacingExtraLarge),

              // Logout Button
              PrimaryButton(
                onPressed: handleLogout,
                text: 'Sign Out'
              ),
              SizedBox(height: 100.sp)
            ]
          )
        )
      )
    );
  }
}
