class FoodItemModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewsCount;
  final String deliveryTime;
  final String category;
  final String description;
  final List<String> ingredients;
  final Map<String, String> nutrition;

  FoodItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewsCount,
    required this.deliveryTime,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.nutrition,
  });
}
