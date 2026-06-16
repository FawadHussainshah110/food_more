import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const RatingStars({
    Key? key,
    required this.rating,
    this.size = 14.0,
    this.color = const Color(0xFFFFB000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final double starVal = index + 1;
        IconData iconData;
        if (rating >= starVal) {
          iconData = Icons.star_rounded;
        } else if (rating >= starVal - 0.5) {
          iconData = Icons.star_half_rounded;
        } else {
          iconData = Icons.star_outline_rounded;
        }
        return Icon(
          iconData,
          size: size.sp,
          color: color,
        );
      }),
    );
  }
}
