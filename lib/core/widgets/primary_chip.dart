import 'package:food_app_task/imports.dart';

class PrimaryChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const PrimaryChip({super.key, required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 22.sp),
        decoration: BoxDecoration(
          gradient: isSelected ? primaryGradientTopRightBottom : null,
          color: isSelected ? null : context.theme.cardColor,
          borderRadius: isSelected ? borderRadiusSmall : BorderRadius.only(topRight: Radius.circular(12.sp)),
        ),
        child: Center(
          child: Text(
            text,
            style: bodyLarge(
              context,
            ).copyWith(color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.hintColor),
          ),
        ),
      ),
    );
  }
}
