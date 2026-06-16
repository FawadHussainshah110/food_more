import 'package:food_app_task/features/home/data/model/food_item_model.dart';

class CartItemModel {
  final FoodItemModel foodItem;
  final int quantity;

  CartItemModel({
    required this.foodItem,
    required this.quantity,
  });
}
