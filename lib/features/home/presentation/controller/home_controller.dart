import 'package:get/get.dart';
import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/home/data/model/restaurant_model.dart';
import 'package:food_app_task/features/home/domain/service/home_service_interface.dart';

class HomeController extends GetxController {
  final HomeServiceInterface homeService;

  HomeController({required this.homeService}) {
    loadHomeData();
  }

  bool isLoadingFoods = false;
  bool isLoadingRestaurants = false;

  final List<FoodItemModel> foodItems = [];
  final List<RestaurantModel> restaurants = [];
  final List<String> categories = [];
  final List<String> banners = [];

  String selectedCategory = 'All';

  void loadHomeData() async {
    loadCategories();
    loadBanners();
    loadFoodItems();
    loadRestaurants();
  }

  void loadCategories() async {
    final list = await homeService.getCategories();
    categories.clear();
    categories.addAll(list);
    update();
  }

  void loadBanners() async {
    final list = await homeService.getBanners();
    banners.clear();
    banners.addAll(list);
    update();
  }

  void loadFoodItems() async {
    isLoadingFoods = true;
    update();
    try {
      final list = await homeService.getFoodItems();
      foodItems.clear();
      foodItems.addAll(list);
    } catch (e) {
      // Handle error
    } finally {
      isLoadingFoods = false;
      update();
    }
  }

  void loadRestaurants() async {
    isLoadingRestaurants = true;
    update();
    try {
      final list = await homeService.getRestaurants();
      restaurants.clear();
      restaurants.addAll(list);
    } catch (e) {
      // Handle error
    } finally {
      isLoadingRestaurants = false;
      update();
    }
  }

  void changeCategory(String category) {
    selectedCategory = category;
    update();
  }

  List<FoodItemModel> get filteredFoods {
    if (selectedCategory == 'All') {
      return foodItems;
    }
    return foodItems.where((food) => food.category.toLowerCase() == selectedCategory.toLowerCase()).toList();
  }

  static HomeController get find => Get.find<HomeController>();
}
