import 'package:get/get.dart';
import 'package:food_app_task/features/cart/data/repository/cart_repo_interface.dart';
import 'package:food_app_task/features/cart/data/repository/cart_repo.dart';
import 'package:food_app_task/features/cart/domain/service/cart_service_interface.dart';
import 'package:food_app_task/features/cart/domain/service/cart_service.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // repository
    CartRepoInterface cartRepo = CartRepo(storage: Get.find());
    Get.lazyPut(() => cartRepo, fenix: true);

    // service
    CartServiceInterface cartService = CartService(cartRepo: Get.find());
    Get.lazyPut(() => cartService, fenix: true);

    // controller
    Get.lazyPut(() => CartController(cartService: Get.find()), fenix: true);
  }
}
