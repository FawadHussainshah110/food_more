import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_app_task/features/home/data/model/restaurant_model.dart';
import 'package:food_app_task/imports.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
    required this.onTap,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleBounceAnimation(
      onTap: onTap,
      child: Container(
        margin: margin ?? EdgeInsets.only(bottom: spacingDefault),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusLarge,
          boxShadow: AppShadows.cardShadow
        ),
        padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingSmall),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: borderRadiusDefault,
              child: CachedNetworkImage(
                imageUrl: restaurant.imageUrl,
                width: 80.sp,
                height: 80.sp,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: context.theme.disabledColor.withOpacity(0.1),
                  child: Center(
                    child: Icon(Icons.storefront_outlined, color: context.theme.disabledColor)
                  )
                ),
                errorWidget: (context, url, error) => Container(
                  color: context.theme.disabledColor.withOpacity(0.1),
                  child: Icon(Icons.error_outline, color: context.theme.disabledColor)
                )
              )
            ),
            SizedBox(width: spacingDefault),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: bodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: spacingExtraSmall),
                  Text(
                    restaurant.cuisines,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bodySmall(context).copyWith(
                      color: context.theme.hintColor
                    )
                  ),
                  SizedBox(height: spacingExtraSmall),
                  Wrap(
                    spacing: spacingSmall,
                    runSpacing: spacingExtraSmall,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded, size: 14.sp, color: context.theme.colorScheme.inverseSurface),
                          SizedBox(width: spacingExtraSmall / 2),
                          Text(
                            '${restaurant.rating}',
                            style: labelLarge(context).copyWith(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(width: spacingExtraSmall / 2),
                          Text(
                            '(${restaurant.reviewsCount}+)',
                            style: labelLarge(context).copyWith(
                              fontSize: 11.sp,
                              color: context.theme.disabledColor
                            )
                          )
                        ]
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time_filled_rounded, size: 12.sp, color: context.theme.disabledColor),
                          SizedBox(width: spacingExtraSmall / 2),
                          Text(
                            restaurant.deliveryTime,
                            style: labelLarge(context).copyWith(
                              fontSize: 11.sp,
                              color: context.theme.hintColor
                            )
                          )
                        ]
                      )
                    ]
                  ),
                  SizedBox(height: spacingExtraSmall),
                  Wrap(
                    spacing: spacingSmall,
                    runSpacing: spacingExtraSmall,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_rounded, size: 12.sp, color: context.theme.primaryColor),
                          SizedBox(width: spacingExtraSmall / 2),
                          Text(
                            restaurant.distance,
                            style: labelLarge(context).copyWith(
                              fontSize: 11.sp,
                              color: context.theme.hintColor
                            )
                          )
                        ]
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delivery_dining_rounded, size: 14.sp, color: context.theme.primaryColor),
                          SizedBox(width: spacingExtraSmall / 2),
                          Text(
                            restaurant.deliveryFee == 0 ? 'Free Delivery' : '\$${restaurant.deliveryFee.toStringAsFixed(2)}',
                            style: labelLarge(context).copyWith(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: context.theme.primaryColor
                            )
                          )
                        ]
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
