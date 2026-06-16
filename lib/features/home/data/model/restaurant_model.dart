class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String deliveryTime;
  final String cuisines;
  final double deliveryFee;
  final String distance;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.deliveryTime,
    required this.cuisines,
    required this.deliveryFee,
    required this.distance,
  });
}
