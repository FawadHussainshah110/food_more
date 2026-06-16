import 'package:food_app_task/features/auth/presentation/components/social_sign_in_button.dart';
import 'package:food_app_task/features/auth/presentation/controller/auth_controller.dart';
import 'package:food_app_task/imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Top ambient glow bubble (Accent/Teal-ish glow)
          Positioned(
            top: -100.sp,
            right: -100.sp,
            child: Container(
              width: 300.sp,
              height: 300.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.colorScheme.inversePrimary.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: context.theme.colorScheme.inversePrimary.withValues(alpha: 0.15),
                    blurRadius: 100.sp,
                    spreadRadius: 50.sp,
                  ),
                ],
              ),
            ),
          ),

          // Bottom ambient glow bubble (Primary/Orange glow)
          Positioned(
            bottom: -50.sp,
            left: -100.sp,
            child: Container(
              width: 350.sp,
              height: 350.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.primaryColor.withValues(alpha: 0.12),
                boxShadow: [BoxShadow(color: context.theme.primaryColor.withValues(alpha: 0.12), blurRadius: 120.sp, spreadRadius: 60.sp)],
              ),
            ),
          ),

          // Main Content Layout
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacingDefault),
              child: Column(
                children: [
                  const Spacer(),

                  // Hero Illustration & Branding Section
                  FadeSlideAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: Column(
                      children: [
                        // Floating Hero Illustration
                        Container(
                          width: 160.sp,
                          height: 160.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                context.theme.primaryColor.withValues(alpha: 0.2),
                                context.theme.scaffoldBackgroundColor.withValues(alpha: 0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(color: context.theme.primaryColor.withValues(alpha: 0.3), width: 1.5.sp),
                          ),
                          child: Center(
                            child: Container(
                              width: 120.sp,
                              height: 120.sp,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: context.theme.primaryColor.withValues(alpha: 0.1)),
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [context.theme.primaryColor, context.theme.colorScheme.inversePrimary],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: Icon(Icons.delivery_dining_rounded, size: 80.sp, color: context.theme.colorScheme.onPrimary),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: spacingExtraLarge),

                        // Title/Branding
                        Text('FoodMore', style: displayLarge(context)),
                        SizedBox(height: spacingMedium),

                        // Subtitle text
                        Text(
                          'Your favorite dishes from top-tier kitchens, delivered with premium elegance.',
                          textAlign: TextAlign.center,
                          style: bodyLarge(context),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Glassmorphic Card Container holding the Google Sign-in action
                  FadeSlideAnimation(
                    delay: const Duration(milliseconds: 300),
                    child: GlassContainer(
                      padding: EdgeInsets.all(spacingLarge),
                      borderRadius: radiuslarge,
                      bgGradientStart: context.theme.colorScheme.onPrimary.withValues(alpha: 0.07),
                      bgGradientEnd: context.theme.colorScheme.onPrimary.withValues(alpha: 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Discover & Feast', textAlign: TextAlign.center, style: titleMedium(context)),
                          SizedBox(height: spacingSmall),
                          Text(
                            'Join FoodMore to track your favorite culinary selections and experience seamless delivery.',
                            textAlign: TextAlign.center,
                            style: bodyMedium(context),
                          ),
                          SizedBox(height: spacingLarge),

                          // Google Sign-In button
                          GetBuilder<AuthController>(
                            builder: (authController) {
                              final bool loading = authController.isLoading;
                              return SocialSignInButton(
                                label: loading ? 'Signing In...' : 'Continue with Google',
                                iconPath: Images.googleIcon,
                                onTap: loading ? () {} : authController.loginWithGoogle,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: spacingLarge),

                  // Legal / Footer disclaimer
                  FadeSlideAnimation(
                    delay: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacingDefault),
                      child: Text(
                        'By continuing, you agree to our Terms of Service & Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: bodySmall(context),
                      ),
                    ),
                  ),

                  SizedBox(height: spacingDefault),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
