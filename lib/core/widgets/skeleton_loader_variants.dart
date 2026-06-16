import 'package:food_app_task/imports.dart';
import 'package:food_app_task/core/widgets/shimmer.dart';

class FoodCardSkeleton extends StatelessWidget {
  const FoodCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        width: 160.sp,
        height: 220.sp,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusLarge
        ),
        padding: paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: borderRadiusDefault
              )
            ),
            SizedBox(height: spacingMedium),
            Container(
              height: 14.sp,
              width: 100.sp,
              color: Colors.black
            ),
            SizedBox(height: spacingSmall),
            Container(
              height: 12.sp,
              width: 60.sp,
              color: Colors.black
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16.sp,
                  width: 50.sp,
                  color: Colors.black
                ),
                Container(
                  height: 24.sp,
                  width: 24.sp,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}

class RestaurantCardSkeleton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const RestaurantCardSkeleton({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        margin: margin ?? EdgeInsets.only(bottom: spacingDefault),
        height: 120.sp,
        width: 250.sp,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusLarge
        ),
        padding: paddingMedium,
        child: Row(
          children: [
            Container(
              width: 100.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: borderRadiusDefault
              )
            ),
            SizedBox(width: spacingDefault),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 16.sp,
                    width: 150.sp,
                    color: Colors.black
                  ),
                  SizedBox(height: spacingSmall),
                  Container(
                    height: 12.sp,
                    width: 100.sp,
                    color: Colors.black
                  ),
                  SizedBox(height: spacingMedium),
                  Row(
                    children: [
                      Container(
                        height: 12.sp,
                        width: 30.sp,
                        color: Colors.black
                      ),
                      SizedBox(width: spacingMedium),
                      Container(
                        height: 12.sp,
                        width: 45.sp,
                        color: Colors.black
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
