import 'dart:math';
import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ShakeAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  ShakeAnimationState createState() => ShakeAnimationState();
}

class ShakeAnimationState extends State<ShakeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void shake() {
    controller.forward(from: 0.0);
  }

  double getSineValue(double animationVal) {
    return sin(animationVal * 3 * 2 * pi);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (context, child) {
        final double offset = 10.0 * getSineValue(controller.value);
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
    );
  }
}
