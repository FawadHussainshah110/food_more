import 'dart:async';
import 'package:get/get.dart';
import 'package:food_app_task/features/cart/data/model/cart_item_model.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';
import 'package:food_app_task/features/home/presentation/controller/home_controller.dart';
import '../../data/model/order_model.dart';

class OrderController extends GetxController {
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyOrders();
  }

  void _loadDummyOrders() {
    try {
      if (Get.isRegistered<HomeController>()) {
        final homeController = HomeController.find;
        final dummyFoodItems = homeController.foodItems;
        if (dummyFoodItems.isNotEmpty) {
          orders.add(
            OrderModel(
              id: '10245',
              items: [
                CartItemModel(foodItem: dummyFoodItems[0], quantity: 1),
                if (dummyFoodItems.length > 1)
                  CartItemModel(foodItem: dummyFoodItems[1], quantity: 1),
              ],
              totalAmount: dummyFoodItems[0].price + (dummyFoodItems.length > 1 ? dummyFoodItems[1].price : 0.0) + 2.99,
              date: DateTime.now().subtract(const Duration(days: 1)),
              status: OrderStatus.delivered,
              address: '123 Luxury Avenue, New York, NY 10001',
              notes: 'Leave at front door',
            ),
          );
          return;
        }
      }
    } catch (_) {}

    // Fallback if HomeController is not ready
    orders.add(
      OrderModel(
        id: '10245',
        items: [],
        totalAmount: 17.98,
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: OrderStatus.delivered,
        address: '123 Luxury Avenue, New York, NY 10001',
        notes: 'Leave at front door',
      ),
    );
  }

  void placeOrder({
    required List<CartItemModel> items,
    required double total,
    required String address,
    required String notes,
  }) {
    final newOrder = OrderModel(
      id: (10246 + orders.length).toString(),
      items: List.from(items),
      totalAmount: total,
      date: DateTime.now(),
      status: OrderStatus.placed,
      address: address,
      notes: notes,
    );

    orders.insert(0, newOrder);
    _simulateOrderStatusUpdates(newOrder.id);
  }

  void _simulateOrderStatusUpdates(String orderId) {
    // Update order status over time for demonstration
    // Placed -> Preparing (10s) -> Out for Delivery (25s) -> Delivered (40s)
    Timer(const Duration(seconds: 10), () {
      _updateOrderStatus(orderId, OrderStatus.preparing);
    });

    Timer(const Duration(seconds: 25), () {
      _updateOrderStatus(orderId, OrderStatus.outForDelivery);
    });

    Timer(const Duration(seconds: 40), () {
      _updateOrderStatus(orderId, OrderStatus.delivered);
    });
  }

  void _updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = orders.indexWhere((o) => o.id == orderId);
    if (index >= 0) {
      orders[index] = orders[index].copyWith(status: newStatus);
      orders.refresh();
      update();
    }
  }

  void reorderOrder(OrderModel order) {
    for (final item in order.items) {
      for (int i = 0; i < item.quantity; i++) {
        CartController.find.addToCart(item.foodItem);
      }
    }
  }

  static OrderController get find => Get.find<OrderController>();
}
