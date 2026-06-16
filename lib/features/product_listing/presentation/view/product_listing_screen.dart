import 'package:flutter/services.dart';
import 'package:food_app_task/features/home/presentation/controller/home_controller.dart';
import 'package:food_app_task/features/product_details/presentation/view/product_details_screen.dart';
import 'package:food_app_task/imports.dart';

class ProductListingScreen extends StatefulWidget {
  final String title;

  const ProductListingScreen({super.key, required this.title});

  @override
  ProductListingScreenState createState() => ProductListingScreenState();
}

class ProductListingScreenState extends State<ProductListingScreen> {
  bool _isGridView = true;

  void toggleView() {
    HapticFeedback.lightImpact();
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: titleMedium(context).copyWith(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: pop),
        actions: [IconButton(icon: Icon(_isGridView ? Icons.list_rounded : Icons.grid_view_rounded), onPressed: toggleView)],
      ),
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            final list = controller.foodItems;
            if (list.isEmpty) {
              return const Center(child: Text('No products available.'));
            }

            if (_isGridView) {
              return GridView.builder(
                padding: paddingDefault,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: spacingDefault,
                  mainAxisSpacing: spacingDefault,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final food = list[index];
                  return FoodCard(
                    foodItem: food,
                    heroTag: 'food_image_${food.id}_listing',
                    onTap: () => launchScreen(ProductDetailsScreen(foodItem: food, heroTag: 'food_image_${food.id}_listing')),
                  );
                },
              );
            } else {
              return ListView.builder(
                padding: paddingDefault,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final food = list[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spacingDefault),
                    child: FoodCard(
                      foodItem: food,
                      heroTag: 'food_image_${food.id}_listing',
                      onTap: () => launchScreen(ProductDetailsScreen(foodItem: food, heroTag: 'food_image_${food.id}_listing')),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
