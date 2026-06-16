import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app_task/features/cart/data/model/cart_item_model.dart';
import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'cart_repo_interface.dart';

class CartRepo implements CartRepoInterface {
  final FlutterSecureStorage storage;

  CartRepo({required this.storage});

  @override
  Future<List<CartItemModel>> loadCart() async {
    final String? cartStr = await storage.read(key: 'cart');
    if (cartStr == null) return [];
    try {
      final List<dynamic> list = jsonDecode(cartStr);
      return list.map((item) {
        final food = item['foodItem'];
        return CartItemModel(
          quantity: item['quantity'],
          foodItem: FoodItemModel(
            id: food['id'],
            name: food['name'],
            imageUrl: food['imageUrl'],
            price: food['price'].toDouble(),
            originalPrice: food['originalPrice'] != null ? food['originalPrice'].toDouble() : null,
            rating: food['rating'].toDouble(),
            reviewsCount: food['reviewsCount'],
            deliveryTime: food['deliveryTime'],
            category: food['category'],
            description: food['description'],
            ingredients: List<String>.from(food['ingredients']),
            nutrition: Map<String, String>.from(food['nutrition']),
          ),
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> saveCart(List<CartItemModel> items) async {
    final List<Map<String, dynamic>> list = items.map((item) => {
          'quantity': item.quantity,
          'foodItem': {
            'id': item.foodItem.id,
            'name': item.foodItem.name,
            'imageUrl': item.foodItem.imageUrl,
            'price': item.foodItem.price,
            'originalPrice': item.foodItem.originalPrice,
            'rating': item.foodItem.rating,
            'reviewsCount': item.foodItem.reviewsCount,
            'deliveryTime': item.foodItem.deliveryTime,
            'category': item.foodItem.category,
            'description': item.foodItem.description,
            'ingredients': item.foodItem.ingredients,
            'nutrition': item.foodItem.nutrition,
          }
        }).toList();
    await storage.write(key: 'cart', value: jsonEncode(list));
    return true;
  }
}
