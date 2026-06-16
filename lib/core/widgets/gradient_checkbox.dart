import 'package:food_app_task/imports.dart';

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  const GradientCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(4.sp),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: spacingLarge,
        height: spacingLarge,
        decoration: BoxDecoration(
          borderRadius: borderRadiusSmall,
          gradient: value ? primaryGradientTopRightBottom : null,
          color: value ? null : Colors.transparent,
          border: Border.all(color: context.theme.hintColor, width: 0.7.sp),
        ),
        child: value
            ? TweenAnimationBuilder<double>(
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 250),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Icon(Icons.check, size: spacingDefault, color: context.theme.colorScheme.onPrimary),
                  );
                },
              )
            : null,
      ),
    );
  }
}
