import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:food_app_task/core/theme/app_colors.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int minQuantity;
  final double iconSize;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onChanged,
    this.minQuantity = 1,
    this.iconSize = 16.0,
  }) : super(key: key);

  void handleDecrement() {
    if (quantity > minQuantity) {
      HapticFeedback.lightImpact();
      onChanged(quantity - 1);
    }
  }

  void handleIncrement() {
    HapticFeedback.lightImpact();
    onChanged(quantity + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 4.sp),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: handleDecrement,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(4.sp),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.remove,
                size: iconSize.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 12.sp),
          Text(
            '$quantity',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.sp),
          GestureDetector(
            onTap: handleIncrement,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(4.sp),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Icon(
                Icons.add,
                size: iconSize.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
