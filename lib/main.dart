import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app_task/core/config/payment_config.dart';
import 'package:food_app_task/core/helper/get_di.dart' as di;
import 'package:food_app_task/core/theme/dark_theme.dart' as dark_theme;
import 'package:food_app_task/core/theme/light_theme.dart' as light_theme;
import 'package:food_app_task/features/splash/presentation/view/splash_screen.dart';
import 'package:food_app_task/features/theme/presentation/controller/theme_controller.dart';
import 'package:food_app_task/firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Stripe SDK
  Stripe.publishableKey = PaymentConfig.stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  await Stripe.instance.applySettings();

  await di.init();
  runApp(const FoodMoreApp());
}

class FoodMoreApp extends StatelessWidget {
  const FoodMoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(375, 812), // Standard iPhone dimension for scaling
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<ThemeController>(
          builder: (themeController) {
            return GetMaterialApp(
              title: 'FoodMore',
              debugShowCheckedModeBanner: false,
              theme: light_theme.light(context),
              darkTheme: dark_theme.dark(context),
              themeMode: themeController.themeMode,
              home: const SplashScreen(),
              navigatorObservers: [FlutterSmartDialog.observer],
              builder: FlutterSmartDialog.init(),
            );
          },
        );
      },
    );
  }
}
