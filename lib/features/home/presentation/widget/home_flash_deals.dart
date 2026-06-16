import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/product_details/presentation/view/product_details_screen.dart';
import 'package:food_app_task/imports.dart';

class HomeFlashDeals extends StatelessWidget {
  final List<FoodItemModel> foodItems;

  const HomeFlashDeals({super.key, required this.foodItems});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodItems.length,
        padding: EdgeInsets.symmetric(horizontal: spacingDefault),
        itemBuilder: (context, index) {
          final food = foodItems[index];
          return Container(
            width: 160.sp,
            margin: EdgeInsets.only(right: spacingDefault),
            child: Stack(
              children: [
                FoodCard(
                  foodItem: food,
                  heroTag: 'food_image_${food.id}_flash',
                  onTap: () => launchScreen(ProductDetailsScreen(foodItem: food, heroTag: 'food_image_${food.id}_flash'))
                ),
                Positioned(
                  top: spacingSmall,
                  left: spacingSmall,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spacingSmall, vertical: spacingExtraSmall),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.error,
                      borderRadius: borderRadiusDefault
                    ),
                    child: Text(
                      '50% OFF',
                      style: labelLarge(context).copyWith(
                        color: context.theme.colorScheme.onPrimary,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold
                      )
                    )
                  )
                )
              ]
            )
          );
        }
      )
    );
  }
}
