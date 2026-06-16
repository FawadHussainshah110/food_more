import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_app_task/features/home/data/model/food_item_model.dart';
import 'package:food_app_task/features/cart/presentation/controller/cart_controller.dart';
import 'package:food_app_task/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:food_app_task/imports.dart';

class FoodCard extends StatelessWidget {
  final FoodItemModel foodItem;
  final VoidCallback onTap;
  final String? heroTag;

  const FoodCard({
    Key? key,
    required this.foodItem,
    required this.onTap,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleBounceAnimation(
      onTap: onTap,
      child: Container(
        width: 160.sp,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusLarge,
          boxShadow: AppShadows.cardShadow
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image & Favorite
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiuslarge)),
                  child: Hero(
                    tag: heroTag ?? 'food_image_${foodItem.id}',
                    child: CachedNetworkImage(
                      imageUrl: foodItem.imageUrl,
                      height: 110.sp,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: context.theme.disabledColor.withValues(alpha: 0.1),
                        child: Center(
                          child: Icon(Icons.fastfood_outlined, color: context.theme.disabledColor)
                        )
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: context.theme.disabledColor.withValues(alpha: 0.1),
                        child: Icon(Icons.error_outline, color: context.theme.disabledColor)
                      )
                    )
                  )
                ),
                // Favorite Button
                Positioned(
                  top: 8.sp,
                  right: 8.sp,
                  child: GetBuilder<WishlistController>(
                    builder: (wishlistController) {
                      final isFav = wishlistController.isFavorite(foodItem.id);
                      return GestureDetector(
                        onTap: () => wishlistController.toggleFavorite(foodItem.id),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.cardColor.withValues(alpha: 0.9)
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => ScaleTransition(
                              scale: animation,
                              child: child
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              key: ValueKey<bool>(isFav),
                              size: 16.sp,
                              color: isFav ? context.theme.colorScheme.error : context.theme.hintColor
                            )
                          )
                        )
                      );
                    }
                  )
                )
              ]
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    foodItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600
                    )
                  ),
                  SizedBox(height: spacingExtraSmall),
                  // Rating & Delivery Time
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 14.sp, color: const Color(0xFFFFB000)),
                      SizedBox(width: 2.sp),
                      Text(
                        '${foodItem.rating}',
                        style: bodySmall(context).copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox(width: spacingSmall),
                      Icon(Icons.access_time_filled_rounded, size: 12.sp, color: context.theme.disabledColor),
                      SizedBox(width: 2.sp),
                      Text(
                        foodItem.deliveryTime,
                        style: bodySmall(context).copyWith(
                          fontSize: 11.sp,
                          color: context.theme.hintColor
                        )
                      )
                    ]
                  ),
                  SizedBox(height: spacingSmall),
                  // Price & Add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PriceText(
                          price: foodItem.price,
                          originalPrice: foodItem.originalPrice,
                          fontSize: 14.0
                        )
                      ),
                      GetBuilder<CartController>(
                        builder: (cartController) {
                          final qty = cartController.getQuantity(foodItem.id);
                          if (qty > 0) {
                            return QuantitySelector(
                              quantity: qty,
                              onChanged: (newQty) => cartController.updateQuantity(foodItem.id, newQty)
                            );
                          }
                          return GestureDetector(
                            onTap: () => cartController.addToCart(foodItem),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.all(6.sp),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.theme.primaryColor
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16.sp,
                                color: context.theme.colorScheme.onPrimary
                              )
                            )
                          );
                        }
                      )
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
