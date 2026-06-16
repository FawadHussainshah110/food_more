import 'package:get/get.dart';
import 'package:food_app_task/features/cart/data/model/cart_item_model.dart';
import 'package:food_app_task/features/cart/domain/service/cart_service_interface.dart';
import 'package:food_app_task/features/home/data/model/food_item_model.dart';

class CartController extends GetxController {
  final CartServiceInterface cartService;

  CartController({required this.cartService}) {
    loadCartFromStorage();
  }

  final List<CartItemModel> cartItems = [];

  void loadCartFromStorage() async {
    final List<CartItemModel> items = await cartService.loadCart();
    cartItems.clear();
    cartItems.addAll(items);
    update();
  }

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + (item.foodItem.price * item.quantity));
  double get deliveryFee => cartItems.isEmpty ? 0.0 : 2.99;
  double get tax => subtotal * 0.08;
  double get total => subtotal + deliveryFee + tax;
  int get totalItemsCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(FoodItemModel foodItem) {
    final index = cartItems.indexWhere((item) => item.foodItem.id == foodItem.id);
    if (index >= 0) {
      final currentQuantity = cartItems[index].quantity;
      cartItems[index] = CartItemModel(foodItem: foodItem, quantity: currentQuantity + 1);
    } else {
      cartItems.add(CartItemModel(foodItem: foodItem, quantity: 1));
    }
    update();
    saveCartToStorage();
  }

  void removeFromCart(String foodItemId) {
    cartItems.removeWhere((item) => item.foodItem.id == foodItemId);
    update();
    saveCartToStorage();
  }

  void updateQuantity(String foodItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(foodItemId);
      return;
    }
    final index = cartItems.indexWhere((item) => item.foodItem.id == foodItemId);
    if (index >= 0) {
      cartItems[index] = CartItemModel(foodItem: cartItems[index].foodItem, quantity: quantity);
    }
    update();
    saveCartToStorage();
  }

  int getQuantity(String foodItemId) {
    final item = cartItems.firstWhereOrNull((item) => item.foodItem.id == foodItemId);
    return item?.quantity ?? 0;
  }

  void clearCart() {
    cartItems.clear();
    update();
    saveCartToStorage();
  }

  void saveCartToStorage() async {
    await cartService.saveCart(cartItems);
  }

  static CartController get find => Get.find<CartController>();
}
