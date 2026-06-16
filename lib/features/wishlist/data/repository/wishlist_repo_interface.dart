abstract class WishlistRepoInterface {
  Future<List<String>> loadWishlist();
  Future<bool> saveWishlist(List<String> ids);
}
