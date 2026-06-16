import '../../data/repository/wishlist_repo_interface.dart';
import 'wishlist_service_interface.dart';

class WishlistService implements WishlistServiceInterface {
  final WishlistRepoInterface wishlistRepo;

  WishlistService({required this.wishlistRepo});

  @override
  Future<List<String>> loadWishlist() {
    return wishlistRepo.loadWishlist();
  }

  @override
  Future<bool> saveWishlist(List<String> ids) {
    return wishlistRepo.saveWishlist(ids);
  }
}
