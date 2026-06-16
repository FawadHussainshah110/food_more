import 'package:food_app_task/imports.dart';

class CheckoutPaymentOption extends StatelessWidget {
  final IconData icon;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const CheckoutPaymentOption({
    super.key,
    required this.icon,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spacingDefault, vertical: spacingMedium),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: borderRadiusLarge,
          border: Border.all(
            color: isSelected ? context.theme.primaryColor : context.theme.disabledColor.withValues(alpha: 0.15),
            width: isSelected ? 2.sp : 1.sp,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? context.theme.primaryColor : context.theme.hintColor, size: 24.sp),
            SizedBox(width: spacingDefault),
            Text(name, style: bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            if (isSelected) Icon(Icons.check_circle_rounded, color: context.theme.primaryColor, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
