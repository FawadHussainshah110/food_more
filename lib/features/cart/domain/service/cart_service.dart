import 'package:food_app_task/features/cart/data/model/cart_item_model.dart';
import 'package:food_app_task/features/cart/data/repository/cart_repo_interface.dart';
import 'cart_service_interface.dart';

class CartService implements CartServiceInterface {
  final CartRepoInterface cartRepo;

  CartService({required this.cartRepo});

  @override
  Future<List<CartItemModel>> loadCart() {
    return cartRepo.loadCart();
  }

  @override
  Future<bool> saveCart(List<CartItemModel> items) {
    return cartRepo.saveCart(items);
  }
}
