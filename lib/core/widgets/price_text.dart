import 'dart:ui';
import 'package:food_app_task/imports.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final double fontSize;
  final Color? color;

  const PriceText({
    Key? key,
    required this.price,
    this.originalPrice,
    this.fontSize = 16.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? context.theme.primaryColor;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w700,
            color: displayColor,
            fontFeatures: const [FontFeature.tabularFigures()]
          )
        ),
        if (originalPrice != null && originalPrice! > price) ...[
          SizedBox(width: 6.sp),
          Text(
            '\$${originalPrice!.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: (fontSize - 3).sp,
              fontWeight: FontWeight.w400,
              color: context.theme.disabledColor,
              decoration: TextDecoration.lineThrough,
              fontFeatures: const [FontFeature.tabularFigures()]
            )
          )
        ]
      ]
    );
  }
}
