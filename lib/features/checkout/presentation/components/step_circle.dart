import 'package:food_app_task/imports.dart';

class StepCircle extends StatelessWidget {
  final int index;
  final String label;
  final bool isCompleted;

  const StepCircle({
    super.key,
    required this.index,
    required this.label,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32.sp,
          height: 32.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? context.theme.primaryColor : Colors.transparent,
            border: Border.all(color: isCompleted ? context.theme.primaryColor : context.theme.disabledColor, width: 2.sp),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: context.theme.colorScheme.onPrimary, size: 16.sp)
                : Text(
                    '${index + 1}',
                    style: bodyMedium(context).copyWith(color: context.theme.disabledColor, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
        SizedBox(height: spacingExtraSmall),
        Text(
          label,
          style: bodySmall(context).copyWith(
            fontSize: 11.sp,
            color: isCompleted ? context.theme.primaryColor : context.theme.disabledColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
