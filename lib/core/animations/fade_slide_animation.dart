import 'package:flutter/material.dart';

class FadeSlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double slideOffset;

  const FadeSlideAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideOffset = 40.0,
  }) : super(key: key);

  @override
  FadeSlideAnimationState createState() => FadeSlideAnimationState();
}

class FadeSlideAnimationState extends State<FadeSlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideOffset / 100),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    if (widget.delay == Duration.zero) {
      controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: widget.child,
      ),
    );
  }
}
