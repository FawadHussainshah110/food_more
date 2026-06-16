import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:food_app_task/imports.dart';
import 'package:food_app_task/features/dashboard/presentation/view/dashboard_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  PaymentSuccessScreenState createState() => PaymentSuccessScreenState();
}

class PaymentSuccessScreenState extends State<PaymentSuccessScreen> with SingleTickerProviderStateMixin {
  late ConfettiController confettiController;
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: const Duration(seconds: 3));
    confettiController.play();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600)
    );
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut)
    );
    controller.forward();
  }

  @override
  void dispose() {
    confettiController.dispose();
    controller.dispose();
    super.dispose();
  }

  void handleHome() {
    launchScreen(const DashboardScreen(), pushAndRemove: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti widget
          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: [
              context.theme.primaryColor,
              context.theme.colorScheme.secondary,
              context.theme.colorScheme.inversePrimary
            ]
          ),
          // Success Details
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(spacingLarge),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.colorScheme.inversePrimary
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 64.sp,
                        color: context.theme.colorScheme.onPrimary
                      )
                    )
                  ),
                  SizedBox(height: spacingExtraLarge),
                  Text(
                    'Order Placed Successfully!',
                    textAlign: TextAlign.center,
                    style: titleLarge(context).copyWith(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: spacingMedium),
                  Text(
                    'Your order has been received and is being prepared.',
                    textAlign: TextAlign.center,
                    style: bodyMedium(context).copyWith(
                      color: context.theme.hintColor
                    )
                  ),
                  SizedBox(height: spacingHuge),
                  PrimaryButton(
                    onPressed: handleHome,
                    text: 'Go to Homepage'
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
