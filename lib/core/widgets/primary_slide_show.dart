import 'dart:async';

import 'package:food_app_task/core/widgets/primary_progress_indicator.dart';
import 'package:food_app_task/imports.dart';

class PrimaryCarouselSlider extends StatefulWidget {
  final List<Widget> items;
  final double? height;
  final Duration autoPlayInterval;
  final bool autoPlay;

  const PrimaryCarouselSlider({
    super.key,
    required this.items,
    this.height,
    this.autoPlayInterval = const Duration(seconds: 6),
    this.autoPlay = true,
  });

  @override
  State<PrimaryCarouselSlider> createState() => _PrimaryCarouselSliderState();
}

class _PrimaryCarouselSliderState extends State<PrimaryCarouselSlider> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      _currentIndex = (_currentIndex + 1) % widget.items.length;
      _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height ?? 150.sp,
          width: Get.width,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
                  }

                  return Center(
                    child: Transform.scale(
                      scale: value,
                      child: AnimatedOpacity(duration: const Duration(milliseconds: 400), opacity: value, child: widget.items[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: spacingMedium),
        PrimaryDotIndicator(dotsLength: widget.items.length, currentIndex: _currentIndex, dotSize: 4.sp),
      ],
    );
  }
}
