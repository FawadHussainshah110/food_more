import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:food_app_task/imports.dart';
import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';
import 'package:food_app_task/features/wishlist/presentation/controller/wishlist_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final FoodItemModel foodItem;
  final String? heroTag;

  const ProductDetailsScreen({Key? key, required this.foodItem, this.heroTag}) : super(key: key);

  void handleBack() {
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Collapsing SliverAppBar
          SliverAppBar(
            expandedHeight: 280.sp,
            pinned: true,
            leading: GestureDetector(
              onTap: handleBack,
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: EdgeInsets.all(spacingSmall),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.cardColor.withValues(alpha: 0.9)
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18.sp,
                  color: bodyMedium(context).color
                )
              )
            ),
            actions: [
              GetBuilder<WishlistController>(
                builder: (wishlistController) {
                  final isFav = wishlistController.isFavorite(foodItem.id);
                  return GestureDetector(
                    onTap: () => wishlistController.toggleFavorite(foodItem.id),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.all(spacingSmall),
                      padding: EdgeInsets.all(spacingSmall),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.cardColor.withValues(alpha: 0.9)
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 20.sp,
                        color: isFav ? context.theme.colorScheme.error : context.theme.hintColor
                      )
                    )
                  );
                }
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: heroTag ?? 'food_image_${foodItem.id}',
                child: CachedNetworkImage(
                  imageUrl: foodItem.imageUrl,
                  fit: BoxFit.cover
                )
              )
            )
          ),

          // Content Details
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(spacingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          foodItem.name,
                          style: titleLarge(context).copyWith(
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spacingSmall, vertical: spacingExtraSmall),
                        decoration: BoxDecoration(
                          color: context.theme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.sp)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star_rounded, size: 16.sp, color: const Color(0xFFFFB000)),
                            SizedBox(width: spacingExtraSmall),
                            Text(
                              '${foodItem.rating}',
                              style: bodySmall(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.primaryColor
                              )
                            )
                          ]
                        )
                      )
                    ]
                  ),
                  SizedBox(height: spacingMedium),

                  // Delivery info & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded, size: 16.sp, color: context.theme.disabledColor),
                          SizedBox(width: spacingExtraSmall),
                          Text(
                            foodItem.deliveryTime,
                            style: bodySmall(context).copyWith(
                              color: context.theme.hintColor
                            )
                          )
                        ]
                      ),
                      PriceText(price: foodItem.price, originalPrice: foodItem.originalPrice, fontSize: 20.0)
                    ]
                  ),
                  SizedBox(height: spacingLarge),

                  // Description
                  Text(
                    'Description',
                    style: bodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: spacingSmall),
                  Text(
                    foodItem.description,
                    style: bodyMedium(context).copyWith(
                      color: context.theme.hintColor,
                      height: 1.5
                    )
                  ),
                  SizedBox(height: spacingLarge),

                  // Nutrition values
                  Text(
                    'Nutrition Facts',
                    style: bodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: spacingMedium),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: foodItem.nutrition.entries.map((entry) {
                        return Container(
                          margin: EdgeInsets.only(right: spacingMedium),
                          padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
                          decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            borderRadius: borderRadiusLarge,
                            boxShadow: AppShadows.cardShadow
                          ),
                          child: Column(
                            children: [
                              Text(
                                entry.value,
                                style: bodyMedium(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.primaryColor
                                )
                              ),
                              SizedBox(height: spacingExtraSmall),
                              Text(
                                entry.key,
                                style: bodySmall(context).copyWith(
                                  color: context.theme.hintColor
                                )
                              )
                            ]
                          )
                        );
                      }).toList()
                    )
                  ),
                  SizedBox(height: 100.sp)
                ]
              )
            )
          )
        ]
      ),
      // Sticky Add to Cart bottom bar
      bottomSheet: Container(
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.sp)),
          boxShadow: AppShadows.bottomNav
        ),
        child: GetBuilder<CartController>(
          builder: (cartController) {
            final qty = cartController.getQuantity(foodItem.id);
            final inCart = qty > 0;
            return Row(
              children: [
                QuantitySelector(
                  quantity: qty == 0 ? 1 : qty,
                  onChanged: (newQty) {
                    if (qty == 0) {
                      cartController.addToCart(foodItem);
                    }
                    cartController.updateQuantity(foodItem.id, newQty);
                  },
                  iconSize: 20.0
                ),
                SizedBox(width: 20.sp),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      if (!inCart) {
                        cartController.addToCart(foodItem);
                        HapticFeedback.mediumImpact();
                      } else {
                        showCustomSnackBar('Already in Cart!', isError: false);
                      }
                    },
                    text: inCart ? 'Added to Cart' : 'Add to Cart'
                  )
                )
              ]
            );
          }
        )
      )
    );
  }
}
