import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaleBounceAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const ScaleBounceAnimation({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  ScaleBounceAnimationState createState() => ScaleBounceAnimationState();
}

class ScaleBounceAnimationState extends State<ScaleBounceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleTapDown(TapDownDetails details) {
    controller.forward();
    HapticFeedback.lightImpact();
  }

  void handleTapUp(TapUpDetails details) {
    controller.reverse();
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void handleTapCancel() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: handleTapDown,
      onTapUp: handleTapUp,
      onTapCancel: handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
