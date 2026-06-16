import 'package:get/get.dart';
import 'package:food_app_task/features/wishlist/domain/service/wishlist_service_interface.dart';

class WishlistController extends GetxController {
  final WishlistServiceInterface wishlistService;

  WishlistController({required this.wishlistService}) {
    loadWishlistFromStorage();
  }

  final List<String> wishlistIds = [];

  void loadWishlistFromStorage() async {
    final List<String> ids = await wishlistService.loadWishlist();
    wishlistIds.clear();
    wishlistIds.addAll(ids);
    update();
  }

  void toggleFavorite(String foodId) {
    if (wishlistIds.contains(foodId)) {
      wishlistIds.remove(foodId);
    } else {
      wishlistIds.add(foodId);
    }
    update();
    saveWishlistToStorage();
  }

  bool isFavorite(String foodId) {
    return wishlistIds.contains(foodId);
  }

  void saveWishlistToStorage() async {
    await wishlistService.saveWishlist(wishlistIds);
  }

  static WishlistController get find => Get.find<WishlistController>();
}
