import 'package:get/get.dart';
import 'package:food_app_task/features/wishlist/data/repository/wishlist_repo_interface.dart';
import 'package:food_app_task/features/wishlist/data/repository/wishlist_repo.dart';
import 'package:food_app_task/features/wishlist/domain/service/wishlist_service_interface.dart';
import 'package:food_app_task/features/wishlist/domain/service/wishlist_service.dart';
import 'package:food_app_task/features/wishlist/presentation/controller/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    // repository
    WishlistRepoInterface wishlistRepo = WishlistRepo(storage: Get.find());
    Get.lazyPut(() => wishlistRepo, fenix: true);

    // service
    WishlistServiceInterface wishlistService = WishlistService(wishlistRepo: Get.find());
    Get.lazyPut(() => wishlistService, fenix: true);

    // controller
    Get.lazyPut(() => WishlistController(wishlistService: Get.find()), fenix: true);
  }
}
