import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app_task/imports.dart';
import 'package:food_app_task/features/home/presentation/controller/home_controller.dart';
import 'package:food_app_task/features/product_details/presentation/view/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void handleSearch(String val) {
    searchQuery.value = val;
  }

  void applySuggestion(String tag) {
    searchController.text = tag;
    searchQuery.value = tag;
  }

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.find;
    final List<String> suggestions = ['Burger', 'Pizza', 'Sushi', 'Dessert', 'Drinks'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spacingDefault),
              Text(
                'Search',
                style: headlineSmall(context).copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: spacingDefault),
              // Search Input
              CustomTextField(
                controller: searchController,
                hintText: 'Search for foods...',
                prefixIcon: Icons.search_rounded,
                onChanged: handleSearch
              ),
              SizedBox(height: spacingDefault),
              // Suggestion Chips
              Text(
                'Suggestions',
                style: bodyMedium(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.hintColor
                )
              ),
              SizedBox(height: spacingSmall),
              Wrap(
                spacing: spacingSmall,
                runSpacing: spacingSmall,
                children: suggestions.map((tag) {
                  return GestureDetector(
                    onTap: () => applySuggestion(tag),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spacingMedium, vertical: spacingSmall),
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20.sp)
                      ),
                      child: Text(
                        tag,
                        style: bodySmall(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColor
                        )
                      )
                    )
                  );
                }).toList()
              ),
              SizedBox(height: spacingLarge),
              // Search Results
              Expanded(
                child: Obx(() {
                  final query = searchQuery.value.toLowerCase().trim();
                  if (query.isEmpty) {
                    return const Center(
                      child: Text('Type something to search...')
                    );
                  }
                  final results = homeController.foodItems.where((food) {
                    return food.name.toLowerCase().contains(query) ||
                        food.category.toLowerCase().contains(query) ||
                        food.description.toLowerCase().contains(query);
                  }).toList();

                  if (results.isEmpty) {
                    return const Center(
                      child: Text('No results found.')
                    );
                  }

                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final food = results[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spacingDefault),
                        child: FoodCard(
                          foodItem: food,
                          heroTag: 'food_image_${food.id}_search',
                          onTap: () => launchScreen(ProductDetailsScreen(foodItem: food, heroTag: 'food_image_${food.id}_search'))
                        )
                      );
                    }
                  );
                })
              )
            ]
          )
        )
      )
    );
  }
}
