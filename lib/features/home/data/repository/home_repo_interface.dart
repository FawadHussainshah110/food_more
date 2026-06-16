import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/home/data/model/restaurant_model.dart';

abstract class HomeRepoInterface {
  Future<List<FoodItemModel>> getFoodItems();
  Future<List<RestaurantModel>> getRestaurants();
  Future<List<String>> getCategories();
  Future<List<String>> getBanners();
}
