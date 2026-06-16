abstract class WishlistServiceInterface {
  Future<List<String>> loadWishlist();
  Future<bool> saveWishlist(List<String> ids);
}
