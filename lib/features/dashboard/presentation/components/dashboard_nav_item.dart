import 'package:food_app_task/imports.dart';

class DashboardNavItem extends StatelessWidget {
  final int index;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const DashboardNavItem({
    super.key,
    required this.index,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: spacingMedium, vertical: spacingSmall),
        decoration: BoxDecoration(
          color: isSelected ? context.theme.primaryColor.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: borderRadiusDefault,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              size: 24.sp,
              color: isSelected ? context.theme.primaryColor : context.theme.hintColor,
            ),
            if (isSelected) ...[
              SizedBox(width: spacingExtraSmall),
              Text(
                label,
                style: labelLarge(context).copyWith(fontSize: 11.sp, fontWeight: FontWeight.bold, color: context.theme.primaryColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
