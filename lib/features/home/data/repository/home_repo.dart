import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/home/data/model/restaurant_model.dart';
import 'package:food_app_task/core/helper/dummy_data.dart';
import 'home_repo_interface.dart';

class HomeRepo implements HomeRepoInterface {
  @override
  Future<List<FoodItemModel>> getFoodItems() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return DummyData.foodItems;
  }

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return DummyData.restaurants;
  }

  @override
  Future<List<String>> getCategories() async {
    return DummyData.categories;
  }

  @override
  Future<List<String>> getBanners() async {
    return DummyData.bannerImages;
  }
}
