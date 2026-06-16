import 'package:food_app_task/features/home/presentation/controller/home_controller.dart';
import 'package:food_app_task/features/home/presentation/widget/home_app_bar.dart';
import 'package:food_app_task/features/home/presentation/widget/home_category_chips.dart';
import 'package:food_app_task/features/home/presentation/widget/home_flash_deals.dart';
import 'package:food_app_task/features/home/presentation/widget/home_promo_carousel.dart';
import 'package:food_app_task/features/home/presentation/widget/home_search_bar.dart';
import 'package:food_app_task/features/home/presentation/widget/home_section_header.dart';
import 'package:food_app_task/features/product_details/presentation/view/product_details_screen.dart';
import 'package:food_app_task/features/product_listing/presentation/view/product_listing_screen.dart';
import 'package:food_app_task/imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            HomeController.find.loadHomeData();
          },
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 1. App Bar
                  const HomeAppBar(),

                  // 2. Floating Search Bar
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: HomeSearchBarDelegate(
                      onTap: () {
                        showCustomSnackBar('Searching is coming soon!');
                      },
                    ),
                  ),

                  // Spacing
                  SliverToBoxAdapter(child: SizedBox(height: spacingSmall)),

                  // 3. Carousel
                  SliverToBoxAdapter(child: HomePromoCarousel(banners: controller.banners)),

                  // Spacing
                  SliverToBoxAdapter(child: SizedBox(height: spacingDefault)),

                  // 4. Categories Selector
                  SliverToBoxAdapter(
                    child: HomeCategoryChips(
                      categories: controller.categories,
                      selectedCategory: controller.selectedCategory,
                      onSelected: controller.changeCategory,
                    ),
                  ),

                  // 5. Flash Deals Section
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(title: 'Flash Deals', onSeeAll: () => launchScreen(ProductListingScreen(title: 'Flash Deals'))),
                  ),
                  SliverToBoxAdapter(child: HomeFlashDeals(foodItems: controller.foodItems)),

                  // 6. Popular Restaurants Header
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(title: 'Popular Restaurants', onSeeAll: () => launchScreen(ProductListingScreen(title: 'Popular Restaurants')))
                  ),

                  // Popular Restaurants Horizontal List
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 165.sp,
                      child: controller.isLoadingRestaurants
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              padding: EdgeInsets.symmetric(horizontal: spacingDefault),
                              itemBuilder: (context, index) => RestaurantCardSkeleton(margin: EdgeInsets.only(right: spacingDefault)),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.restaurants.length,
                              padding: EdgeInsets.symmetric(horizontal: spacingDefault),
                              itemBuilder: (context, index) {
                                final restaurant = controller.restaurants[index];
                                return Container(
                                  width: 250.sp,
                                  margin: EdgeInsets.only(right: spacingDefault),
                                  child: RestaurantCard(
                                    restaurant: restaurant,
                                    onTap: () => showCustomSnackBar('Details for ${restaurant.name}'),
                                    margin: EdgeInsets.zero,
                                  ),
                                );
                              },
                            ),
                    ),
                  ),

                  // 7. Trending Foods Header
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(title: 'Trending Foods', onSeeAll: () => launchScreen(ProductListingScreen(title: 'Trending Foods')))
                  ),

                  // Trending Foods Grid
                  if (controller.isLoadingFoods)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: spacingDefault),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: spacingDefault,
                          mainAxisSpacing: spacingDefault,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) => const FoodCardSkeleton(), childCount: 4),
                      ),
                    )
                  else ...[
                    if (controller.filteredFoods.isEmpty)
                      const SliverToBoxAdapter(child: Center(child: Text('No items found in this category')))
                    else
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: spacingDefault),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.70,
                            crossAxisSpacing: spacingDefault,
                            mainAxisSpacing: spacingDefault,
                          ),
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final food = controller.filteredFoods[index];
                            return FoodCard(
                              foodItem: food,
                              heroTag: 'food_image_${food.id}_trending',
                              onTap: () => launchScreen(ProductDetailsScreen(foodItem: food, heroTag: 'food_image_${food.id}_trending')),
                            );
                          }, childCount: controller.filteredFoods.length),
                        ),
                      ),
                  ],

                  // 8. Recommended Section
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(title: 'Recommended For You', onSeeAll: () => launchScreen(ProductListingScreen(title: 'Recommended')))
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final food = controller.foodItems[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
                        child: FoodCard(
                          foodItem: food,
                          heroTag: 'food_image_${food.id}_recommended',
                          onTap: () => launchScreen(ProductDetailsScreen(foodItem: food, heroTag: 'food_image_${food.id}_recommended')),
                        ),
                      );
                    }, childCount: controller.foodItems.length > 3 ? 3 : controller.foodItems.length),
                  ),

                  // 9. Nearby Restaurants Section
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(title: 'Nearby Restaurants', onSeeAll: () => launchScreen(ProductListingScreen(title: 'Nearby Restaurants')))
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final rest = controller.restaurants[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
                        child: RestaurantCard(restaurant: rest, onTap: () => showCustomSnackBar('Details for ${rest.name}')),
                      );
                    }, childCount: controller.restaurants.length),
                  ),

                  // 10. Best Rated Restaurants Section
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(title: 'Best Rated Restaurants', onSeeAll: () => launchScreen(ProductListingScreen(title: 'Best Rated')))
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final rest = controller.restaurants[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
                        child: RestaurantCard(restaurant: rest, onTap: () => showCustomSnackBar('Details for ${rest.name}')),
                      );
                    }, childCount: controller.restaurants.length),
                  ),

                  // Bottom Spacing for Floating Navigation Bar
                  SliverToBoxAdapter(child: SizedBox(height: 100.sp)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
