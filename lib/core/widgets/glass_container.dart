import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final Color borderGradientStart;
  final Color borderGradientEnd;
  final Color bgGradientStart;
  final Color bgGradientEnd;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const GlassContainer({
    Key? key,
    required this.child,
    this.borderRadius = 16.0,
    this.blur = 10.0,
    this.borderGradientStart = const Color(0x33FFFFFF),
    this.borderGradientEnd = const Color(0x0DFFFFFF),
    this.bgGradientStart = const Color(0x1AFFFFFF),
    this.bgGradientEnd = const Color(0x05FFFFFF),
    this.padding,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: [bgGradientStart, bgGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
