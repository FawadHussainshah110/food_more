import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'wishlist_repo_interface.dart';

class WishlistRepo implements WishlistRepoInterface {
  final FlutterSecureStorage storage;

  WishlistRepo({required this.storage});

  @override
  Future<List<String>> loadWishlist() async {
    final String? data = await storage.read(key: 'wishlist');
    if (data == null) return [];
    try {
      final List<dynamic> list = jsonDecode(data);
      return list.map((e) => e.toString()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> saveWishlist(List<String> ids) async {
    await storage.write(key: 'wishlist', value: jsonEncode(ids));
    return true;
  }
}
