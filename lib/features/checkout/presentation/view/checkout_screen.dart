import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';
import 'package:food_app_task/features/checkout/presentation/components/payment_option.dart';
import 'package:food_app_task/features/checkout/presentation/components/step_circle.dart';
import 'package:food_app_task/features/orders/presentation/controller/order_controller.dart';
import 'package:food_app_task/features/payment/data/repository/payment_repo_interface.dart';
import 'package:food_app_task/features/payment/presentation/view/payment_success_screen.dart';
import 'package:food_app_task/imports.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController = TextEditingController(text: '123 Luxury Avenue, New York, NY 10001');
  final TextEditingController notesController = TextEditingController();
  int _activeStep = 0;
  int _selectedPaymentMethod = 0;

  @override
  void dispose() {
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _processStripePayment() async {
    final cartController = CartController.find;
    final double amount = cartController.total;

    if (amount <= 0) {
      showCustomSnackBar('Invalid cart total amount');
      return;
    }

    // Dismiss any Flutter keyboard/focus to prevent conflicts with native Stripe fields
    FocusScope.of(context).unfocus();

    showLoading();

    try {
      final paymentRepo = Get.find<PaymentRepoInterface>();
      await paymentRepo.processStripePayment(amount: amount, currency: 'usd');

      hideLoading();

      // On Payment Success, save order in OrderController, clear the cart and navigate to success screen
      Get.find<OrderController>().placeOrder(
        items: cartController.cartItems,
        total: amount,
        address: addressController.text,
        notes: notesController.text,
      );

      cartController.clearCart();
      launchScreen(const PaymentSuccessScreen());
    } on StripeException catch (e) {
      hideLoading();
      if (e.error.code == FailureCode.Canceled) {
        showCustomSnackBar('Payment cancelled.');
      } else {
        showCustomSnackBar('Payment failed: ${e.error.localizedMessage ?? e.error.message ?? 'Unknown error'}');
      }
    } catch (e) {
      hideLoading();
      final errorMsg = e.toString().replaceFirst('Exception: ', '');
      showCustomSnackBar(errorMsg);
    }
  }

  void handleNext() {
    HapticFeedback.lightImpact();
    if (_activeStep < 1) {
      setState(() {
        _activeStep++;
      });
    } else {
      _processStripePayment();
    }
  }

  void handleBack() {
    HapticFeedback.lightImpact();
    if (_activeStep > 0) {
      setState(() {
        _activeStep--;
      });
    } else {
      pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: titleMedium(context).copyWith(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: handleBack),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spacingDefault),
              // Step Indicator
              Row(
                children: [
                  StepCircle(index: 0, label: 'Delivery', isCompleted: _activeStep >= 0),
                  Expanded(
                    child: Container(height: 2.sp, color: _activeStep >= 1 ? context.theme.primaryColor : context.theme.disabledColor),
                  ),
                  StepCircle(index: 1, label: 'Payment', isCompleted: _activeStep >= 1),
                ],
              ),
              SizedBox(height: spacingExtraLarge),
              // Active Step Body
              Expanded(
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    if (_activeStep == 0) {
                      return ListView(
                        children: [
                          Text('Delivery Address', style: bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: spacingMedium),
                          CustomTextField(
                            controller: addressController,
                            hintText: 'Enter your address',
                            prefixIcon: Icons.location_on_rounded,
                          ),
                          SizedBox(height: spacingLarge),
                          Text('Delivery Notes', style: bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: spacingMedium),
                          CustomTextField(
                            controller: notesController,
                            hintText: 'e.g. Leave at door, call when outside...',
                            prefixIcon: Icons.note_add_rounded,
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                        children: [
                          Text('Select Payment Method', style: bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: spacingDefault),
                          CheckoutPaymentOption(
                            icon: Icons.credit_card_rounded,
                            name: 'Stripe',
                            isSelected: _selectedPaymentMethod == 0,
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 0;
                              });
                            },
                          ),
                          SizedBox(height: spacingLarge),
                          // Summary breakdown
                          Container(
                            padding: paddingDefault,
                            decoration: BoxDecoration(
                              color: context.theme.cardColor,
                              borderRadius: borderRadiusLarge,
                              boxShadow: AppShadows.cardShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order Summary', style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                                SizedBox(height: spacingMedium),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Items', style: bodySmall(context).copyWith(color: context.theme.hintColor)),
                                    Text('${controller.totalItemsCount}', style: bodySmall(context).copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(height: spacingSmall),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Grand Total', style: bodySmall(context).copyWith(fontWeight: FontWeight.bold)),
                                    Text(
                                      '\$${controller.total.toStringAsFixed(2)}',
                                      style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold, color: context.theme.primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              // Sticky bottom bar
              Center(
                child: PrimaryButton(onPressed: handleNext, text: _activeStep == 0 ? 'Proceed to Payment' : 'Place Order'),
              ),
              SizedBox(height: spacingDefault),
            ],
          ),
        ),
      ),
    );
  }
}
