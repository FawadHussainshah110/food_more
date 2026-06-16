import 'package:flutter/material.dart';
import 'package:food_app_task/features/orders/data/model/order_model.dart';
import 'package:food_app_task/features/orders/presentation/controller/order_controller.dart';
import 'package:food_app_task/features/orders/presentation/view/order_tracking_screen.dart';
import 'package:food_app_task/imports.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingDefault),
          child: GetBuilder<OrderController>(
            builder: (controller) {
              final allOrders = controller.orders;
              if (allOrders.isEmpty) {
                return _buildEmptyState(context);
              }

              final activeOrders = allOrders.where((o) => o.status != OrderStatus.delivered).toList();
              final pastOrders = allOrders.where((o) => o.status == OrderStatus.delivered).toList();

              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: spacingDefault),
                  Text(
                    'My Orders',
                    style: titleLarge(context).copyWith(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: spacingLarge),

                  if (activeOrders.isNotEmpty) ...[
                    Text(
                      'Active Orders',
                      style: bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor
                      )
                    ),
                    SizedBox(height: spacingDefault),
                    ...activeOrders.map((order) => _buildOrderCard(context, order, controller)),
                    SizedBox(height: spacingLarge),
                  ],

                  if (pastOrders.isNotEmpty) ...[
                    Text(
                      'Past Orders',
                      style: bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: spacingDefault),
                    ...pastOrders.map((order) => _buildOrderCard(context, order, controller)),
                  ],
                  SizedBox(height: 100.sp),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 80.sp,
            color: context.theme.disabledColor.withValues(alpha: 0.5),
          ),
          SizedBox(height: spacingLarge),
          Text(
            'No orders yet',
            style: titleMedium(context).copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: spacingSmall),
          Text(
            'Order delicious meals from the store to track them here!',
            style: bodySmall(context).copyWith(color: context.theme.hintColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order, OrderController controller) {
    final isActive = order.status != OrderStatus.delivered;
    final formattedDate = DateFormat('MMMM dd, yyyy - hh:mm a').format(order.date);

    // Create readable items string
    String itemsText = '';
    if (order.items.isNotEmpty) {
      itemsText = order.items.map((e) => '${e.quantity}x ${e.foodItem.name}').join(', ');
    } else {
      itemsText = 'Custom checkout order';
    }

    return GestureDetector(
      onTap: () {
        launchScreen(OrderTrackingScreen(orderId: order.id));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(bottom: spacingDefault),
        padding: EdgeInsets.all(spacingDefault),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusDefault,
          boxShadow: AppShadows.cardShadow
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: bodyMedium(context).copyWith(
                    fontWeight: FontWeight.bold
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spacingSmall, vertical: 2.sp),
                  decoration: BoxDecoration(
                    color: isActive
                        ? context.theme.primaryColor.withValues(alpha: 0.1)
                        : Colors.green.withValues(alpha: 0.1),
                    borderRadius: borderRadiusDefault,
                  ),
                  child: Text(
                    order.status.name.capitalizeFirst ?? '',
                    style: labelLarge(context).copyWith(
                      color: isActive ? context.theme.primaryColor : Colors.green,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacingExtraSmall),
            Text(
              formattedDate,
              style: bodySmall(context).copyWith(
                color: context.theme.hintColor
              )
            ),
            Divider(height: 16.sp),
            Text(
              itemsText,
              style: bodyMedium(context).copyWith(
                color: context.theme.hintColor
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: spacingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: bodyLarge(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.primaryColor
                  )
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isActive) {
                      launchScreen(OrderTrackingScreen(orderId: order.id));
                    } else {
                      controller.reorderOrder(order);
                      showCustomSnackBar('Items added back to cart!', isError: false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadiusDefault
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: spacingDefault,
                      vertical: spacingSmall
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ),
                  child: Text(
                    isActive ? 'Track Order' : 'Reorder',
                    style: bodyMedium(context).copyWith(
                      color: context.theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ]
            )
          ]
        )
      ),
    );
  }
}
