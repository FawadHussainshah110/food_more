import 'package:food_app_task/features/auth/presentation/view/login_screen.dart';
import 'package:food_app_task/features/splash/presentation/components/floating_background_emoji.dart';
import 'package:food_app_task/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> logoScale;
  late Animation<double> logoOpacity;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      launchScreen(const LoginScreen(), pushAndRemove: true);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Floating background foods (illustrations/emojis)
          FloatingBackgroundEmoji(
            emoji: '🍕',
            top: 100.sp,
            left: 50.sp,
            delay: const Duration(milliseconds: 300),
            slideOffset: -20,
            fontSize: 32
          ),
          FloatingBackgroundEmoji(
            emoji: '🍔',
            top: 250.sp,
            right: 80.sp,
            delay: const Duration(milliseconds: 600),
            slideOffset: 20,
            fontSize: 40
          ),
          FloatingBackgroundEmoji(
            emoji: '🍣',
            bottom: 200.sp,
            left: 80.sp,
            delay: const Duration(milliseconds: 900),
            slideOffset: -30,
            fontSize: 36
          ),
          FloatingBackgroundEmoji(
            emoji: '🍩',
            bottom: 120.sp,
            right: 60.sp,
            delay: const Duration(milliseconds: 1200),
            slideOffset: 30,
            fontSize: 34
          ),
          // Center Logo & Title
          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Opacity(
                  opacity: logoOpacity.value,
                  child: Transform.scale(scale: logoScale.value, child: child)
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(spacingLarge),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.primaryColor.withValues(alpha: 0.1),
                      border: Border.all(color: context.theme.primaryColor.withValues(alpha: 0.2), width: 2)
                    ),
                    child: Icon(Icons.delivery_dining_rounded, size: 80.sp, color: context.theme.primaryColor)
                  ),
                  SizedBox(height: spacingLarge),
                  Text('FoodMore', style: displayLarge(context)),
                  SizedBox(height: spacingSmall),
                  Text('Premium Food Delivery', style: bodyMedium(context))
                ]
              )
            )
          )
        ]
      )
    );
  }
}
