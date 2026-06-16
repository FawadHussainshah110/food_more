import 'package:food_app_task/features/cart/data/model/cart_item_model.dart';

abstract class CartRepoInterface {
  Future<List<CartItemModel>> loadCart();
  Future<bool> saveCart(List<CartItemModel> items);
}
