import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:food_app_task/imports.dart';

class HomePromoCarousel extends StatefulWidget {
  final List<String> banners;

  const HomePromoCarousel({
    Key? key,
    required this.banners,
  }) : super(key: key);

  @override
  HomePromoCarouselState createState() => HomePromoCarouselState();
}

class HomePromoCarouselState extends State<HomePromoCarousel> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 150.sp,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: spacingDefault),
                decoration: BoxDecoration(
                  borderRadius: borderRadiusLarge
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: widget.banners[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: context.theme.disabledColor.withOpacity(0.1)
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error_outline)
                )
              );
            }
          )
        ),
        SizedBox(height: spacingSmall),
        SmoothPageIndicator(
          controller: pageController,
          count: widget.banners.length,
          effect: ExpandingDotsEffect(
            activeDotColor: context.theme.primaryColor,
            dotColor: context.theme.disabledColor.withOpacity(0.3),
            dotHeight: 6.sp,
            dotWidth: 6.sp,
            expansionFactor: 3,
            spacing: 6.sp
          )
        )
      ]
    );
  }
}
