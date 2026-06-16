import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_task/imports.dart';

class PaymentFailedScreen extends StatefulWidget {
  const PaymentFailedScreen({Key? key}) : super(key: key);

  @override
  PaymentFailedScreenState createState() => PaymentFailedScreenState();
}

class PaymentFailedScreenState extends State<PaymentFailedScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600)
    );
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut)
    );
    controller.forward();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleTryAgain() {
    HapticFeedback.lightImpact();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Failed',
          style: titleMedium(context).copyWith(
            fontWeight: FontWeight.bold
          )
        ),
        automaticallyImplyLeading: false
      ),
      body: SafeArea(
        child: Center(
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
                      color: context.theme.colorScheme.error
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 64.sp,
                      color: context.theme.colorScheme.onError
                    )
                  )
                ),
                SizedBox(height: spacingExtraLarge),
                Text(
                  'Payment Declined!',
                  textAlign: TextAlign.center,
                  style: titleLarge(context).copyWith(
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: spacingMedium),
                Text(
                  'Something went wrong with your card authorization. Please try another card or check your credentials.',
                  textAlign: TextAlign.center,
                  style: bodyMedium(context).copyWith(
                    color: context.theme.hintColor
                  )
                ),
                SizedBox(height: 48.sp),
                PrimaryButton(
                  onPressed: handleTryAgain,
                  text: 'Try Another Method'
                )
              ]
            )
          )
        )
      )
    );
  }
}
