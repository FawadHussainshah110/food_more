import 'package:flutter/material.dart';
import 'package:food_app_task/features/orders/data/model/order_model.dart';
import 'package:food_app_task/features/orders/presentation/controller/order_controller.dart';
import 'package:food_app_task/imports.dart';
import 'package:intl/intl.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order', style: titleMedium(context).copyWith(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<OrderController>(
          builder: (controller) {
            final order = controller.orders.firstWhereOrNull((o) => o.id == orderId);
            if (order == null) {
              return const Center(child: Text('Order not found.'));
            }

            final isPlaced = order.status.index >= OrderStatus.placed.index;
            final isPreparing = order.status.index >= OrderStatus.preparing.index;
            final isOutForDelivery = order.status.index >= OrderStatus.outForDelivery.index;
            final isDelivered = order.status.index >= OrderStatus.delivered.index;

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: spacingDefault),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: spacingDefault),
                // Premium Card for Est Delivery / Map representation
                _buildRiderMapCard(context, order),
                SizedBox(height: spacingLarge),

                // Stepper Header
                Text(
                  'Delivery Status',
                  style: bodyLarge(context).copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: spacingDefault),

                // Stepper Timeline
                Container(
                  padding: paddingDefault,
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: borderRadiusLarge,
                    boxShadow: AppShadows.cardShadow,
                  ),
                  child: Column(
                    children: [
                      _buildTimelineStep(
                        context,
                        title: 'Order Placed',
                        subtitle: 'Your order has been received.',
                        time: DateFormat('hh:mm a').format(order.date),
                        isCompleted: isPlaced,
                        isCurrent: order.status == OrderStatus.placed,
                        isLast: false,
                        icon: Icons.receipt_rounded,
                      ),
                      _buildTimelineStep(
                        context,
                        title: 'Preparing Food',
                        subtitle: 'Our kitchen is cooking your delicious meal.',
                        time: isPreparing ? DateFormat('hh:mm a').format(order.date.add(const Duration(minutes: 5))) : '--:--',
                        isCompleted: isPreparing,
                        isCurrent: order.status == OrderStatus.preparing,
                        isLast: false,
                        icon: Icons.restaurant_rounded,
                      ),
                      _buildTimelineStep(
                        context,
                        title: 'Out for Delivery',
                        subtitle: 'Our rider Robert is carrying your food.',
                        time: isOutForDelivery ? DateFormat('hh:mm a').format(order.date.add(const Duration(minutes: 15))) : '--:--',
                        isCompleted: isOutForDelivery,
                        isCurrent: order.status == OrderStatus.outForDelivery,
                        isLast: false,
                        icon: Icons.delivery_dining_rounded,
                      ),
                      _buildTimelineStep(
                        context,
                        title: 'Delivered',
                        subtitle: 'Enjoy your warm food!',
                        time: isDelivered ? DateFormat('hh:mm a').format(order.date.add(const Duration(minutes: 30))) : '--:--',
                        isCompleted: isDelivered,
                        isCurrent: order.status == OrderStatus.delivered,
                        isLast: true,
                        icon: Icons.home_filled,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacingLarge),

                // Order summary list
                _buildOrderItemsCard(context, order),
                SizedBox(height: spacingExtraLarge),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRiderMapCard(BuildContext context, OrderModel order) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: borderRadiusLarge,
        boxShadow: AppShadows.cardShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Mock Map section
          Container(
            height: 140.sp,
            color: context.theme.primaryColor.withValues(alpha: 0.05),
            child: Stack(
              children: [
                // Custom drawn delivery route background lines
                Positioned.fill(
                  child: CustomPaint(
                    painter: MapRoutePainter(
                      routeColor: context.theme.primaryColor.withValues(alpha: 0.3),
                      activeColor: context.theme.primaryColor,
                      progress: order.status == OrderStatus.placed
                          ? 0.1
                          : order.status == OrderStatus.preparing
                              ? 0.4
                              : order.status == OrderStatus.outForDelivery
                                  ? 0.8
                                  : 1.0,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        order.status == OrderStatus.delivered
                            ? Icons.check_circle_rounded
                            : Icons.directions_bike_rounded,
                        size: 32.sp,
                        color: context.theme.primaryColor,
                      ),
                      SizedBox(height: spacingSmall),
                      Text(
                        order.status == OrderStatus.delivered
                            ? 'Your order has been delivered!'
                            : order.status == OrderStatus.outForDelivery
                                ? 'Rider is close to your location'
                                : 'Preparing your order...',
                        style: labelLarge(context).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Rider info
          Padding(
            padding: paddingDefault,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.sp,
                  backgroundColor: context.theme.primaryColor.withValues(alpha: 0.1),
                  child: Icon(Icons.person, color: context.theme.primaryColor, size: 24.sp),
                ),
                SizedBox(width: spacingDefault),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Robert Fox',
                        style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Food Delivery Rider',
                        style: bodySmall(context).copyWith(color: context.theme.hintColor),
                      ),
                    ],
                  ),
                ),
                // Chat and Call shortcuts
                IconButton(
                  icon: Icon(Icons.message_rounded, color: context.theme.primaryColor),
                  onPressed: () => showCustomSnackBar('Opening chat window with rider...', isError: false),
                ),
                IconButton(
                  icon: Icon(Icons.phone_rounded, color: context.theme.primaryColor),
                  onPressed: () => showCustomSnackBar('Calling rider Robert...', isError: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String time,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
    required IconData icon,
  }) {
    final activeColor = context.theme.primaryColor;
    final inactiveColor = context.theme.disabledColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stepper Visual line + circle
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28.sp,
              height: 28.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCurrent
                    ? activeColor
                    : isCompleted
                        ? activeColor.withValues(alpha: 0.15)
                        : inactiveColor.withValues(alpha: 0.1),
                border: isCurrent
                    ? Border.all(color: activeColor.withValues(alpha: 0.3), width: 4.sp)
                    : null,
              ),
              child: Center(
                child: Icon(
                  isCompleted ? Icons.check_rounded : icon,
                  size: 14.sp,
                  color: isCurrent
                      ? context.theme.colorScheme.onPrimary
                      : isCompleted
                          ? activeColor
                          : inactiveColor,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2.sp,
                height: 48.sp,
                color: isCompleted ? activeColor : inactiveColor.withValues(alpha: 0.3),
              ),
          ],
        ),
        SizedBox(width: spacingDefault),
        // Step details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: bodyMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? activeColor : (isCompleted ? null : inactiveColor),
                    ),
                  ),
                  Text(
                    time,
                    style: bodySmall(context).copyWith(color: context.theme.hintColor),
                  ),
                ],
              ),
              SizedBox(height: spacingExtraSmall),
              Text(
                subtitle,
                style: bodySmall(context).copyWith(
                  color: isCompleted ? context.theme.hintColor : inactiveColor.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemsCard(BuildContext context, OrderModel order) {
    return Container(
      padding: paddingDefault,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: borderRadiusLarge,
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Details #${order.id}',
                style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spacingSmall, vertical: 2.sp),
                decoration: BoxDecoration(
                  color: order.status == OrderStatus.delivered
                      ? Colors.green.withValues(alpha: 0.15)
                      : context.theme.primaryColor.withValues(alpha: 0.15),
                  borderRadius: borderRadiusDefault,
                ),
                child: Text(
                  order.status.name.capitalizeFirst ?? '',
                  style: labelLarge(context).copyWith(
                    color: order.status == OrderStatus.delivered ? Colors.green : context.theme.primaryColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(height: spacingSmall),
          // Items List
          ...order.items.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: spacingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${item.quantity}x ${item.foodItem.name}',
                    style: bodyMedium(context).copyWith(color: context.theme.hintColor),
                  ),
                  Text(
                    '\$${(item.foodItem.price * item.quantity).toStringAsFixed(2)}',
                    style: bodyMedium(context).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }).toList(),
          if (order.items.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: spacingSmall),
              child: Text(
                'Confidential / Custom Checkout items',
                style: bodyMedium(context).copyWith(fontStyle: FontStyle.italic, color: context.theme.hintColor),
              ),
            ),
          const Divider(),
          SizedBox(height: spacingSmall),
          // Address & Delivery Fee details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Address', style: bodySmall(context).copyWith(fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(
                  order.address,
                  textAlign: TextAlign.right,
                  style: bodySmall(context).copyWith(color: context.theme.hintColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spacingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grand Total', style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold, color: context.theme.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom painter to draw path representation for map mockup
class MapRoutePainter extends CustomPainter {
  final Color routeColor;
  final Color activeColor;
  final double progress;

  MapRoutePainter({
    required this.routeColor,
    required this.activeColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = routeColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final startPoint = Offset(size.width * 0.15, size.height * 0.8);
    final controlPoint1 = Offset(size.width * 0.45, size.height * 0.1);
    final controlPoint2 = Offset(size.width * 0.55, size.height * 0.9);
    final endPoint = Offset(size.width * 0.85, size.height * 0.2);

    final path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint.dx,
        endPoint.dy,
      );

    canvas.drawPath(path, paintLine);

    // Draw active portion based on progress
    final pathMetrics = path.computeMetrics().first;
    final activePath = pathMetrics.extractPath(0.0, pathMetrics.length * progress);
    canvas.drawPath(activePath, activePaint);

    // Draw start and end pin checkpoints
    final pinPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(startPoint, 6.0, pinPaint);

    final destinationPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(endPoint, 6.0, destinationPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
