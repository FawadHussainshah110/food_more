import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';
import 'package:food_app_task/features/checkout/presentation/view/checkout_screen.dart';
import 'package:food_app_task/imports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void handleCheckout() {
    launchScreen(const CheckoutScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingDefault),
          child: GetBuilder<CartController>(
            builder: (controller) {
              final list = controller.cartItems;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spacingDefault),
                  Text('My Cart', style: headlineSmall(context).copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: spacingDefault),
                  // Cart Items List
                  Expanded(
                    child: list.isEmpty
                        ? const Center(child: Text('Your cart is empty!'))
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              return Dismissible(
                                key: Key('cart_item_${item.foodItem.id}'),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  controller.removeFromCart(item.foodItem.id);
                                  HapticFeedback.mediumImpact();
                                  showCustomSnackBar('${item.foodItem.name} removed from cart.');
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: spacingLarge),
                                  decoration: BoxDecoration(
                                    color: context.theme.colorScheme.error.withValues(alpha: 0.1),
                                    borderRadius: borderRadiusLarge,
                                  ),
                                  child: Icon(Icons.delete_outline_rounded, color: context.theme.colorScheme.error, size: 28.sp),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: spacingDefault),
                                  padding: paddingMedium,
                                  decoration: BoxDecoration(
                                    color: context.theme.cardColor,
                                    borderRadius: borderRadiusLarge,
                                    boxShadow: AppShadows.cardShadow,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: borderRadiusDefault,
                                        child: CachedNetworkImage(
                                          imageUrl: item.foodItem.imageUrl,
                                          width: 70.sp,
                                          height: 70.sp,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: spacingDefault),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.foodItem.name, style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                                            SizedBox(height: spacingSmall),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                PriceText(price: item.foodItem.price, fontSize: 14.0),
                                                QuantitySelector(
                                                  quantity: item.quantity,
                                                  onChanged: (newQty) {
                                                    controller.updateQuantity(item.foodItem.id, newQty);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  // Cart Summary Breakdown
                  if (list.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spacingLarge),
                      decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: BorderRadius.circular(24.sp),
                        boxShadow: AppShadows.cardShadow,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal', style: bodySmall(context).copyWith(color: context.theme.hintColor)),
                              Text(
                                '\$${controller.subtotal.toStringAsFixed(2)}',
                                style: bodySmall(context).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingSmall),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee', style: bodySmall(context).copyWith(color: context.theme.hintColor)),
                              Text(
                                '\$${controller.deliveryFee.toStringAsFixed(2)}',
                                style: bodySmall(context).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingSmall),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax', style: bodySmall(context).copyWith(color: context.theme.hintColor)),
                              Text(
                                '\$${controller.tax.toStringAsFixed(2)}',
                                style: bodySmall(context).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingMedium),
                          const Divider(),
                          SizedBox(height: spacingMedium),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: bodyLarge(context).copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                '\$${controller.total.toStringAsFixed(2)}',
                                style: titleSmall(context).copyWith(fontWeight: FontWeight.bold, color: context.theme.primaryColor),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingLarge),
                          PrimaryButton(onPressed: handleCheckout, text: 'Checkout'),
                        ],
                      ),
                    ),
                  SizedBox(height: 100.sp),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
