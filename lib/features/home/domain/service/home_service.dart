import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/home/data/model/restaurant_model.dart';
import 'package:food_app_task/features/home/data/repository/home_repo_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  final HomeRepoInterface homeRepo;

  HomeService({required this.homeRepo});

  @override
  Future<List<FoodItemModel>> getFoodItems() {
    return homeRepo.getFoodItems();
  }

  @override
  Future<List<RestaurantModel>> getRestaurants() {
    return homeRepo.getRestaurants();
  }

  @override
  Future<List<String>> getCategories() {
    return homeRepo.getCategories();
  }

  @override
  Future<List<String>> getBanners() {
    return homeRepo.getBanners();
  }
}
