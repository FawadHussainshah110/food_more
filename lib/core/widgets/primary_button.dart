import 'package:food_app_task/imports.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Widget? icon;
  final double? radius;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  const PrimaryButton({
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
    this.textColor,
    this.radius,
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = Size(width ?? 100.sp, height ?? 40.sp);
    final Color backgroundColor = color ?? primaryColor;
    final Color textColor = this.textColor ?? Colors.white;
    return Container(
      decoration: BoxDecoration(
        color: onPressed == null ? context.theme.disabledColor : backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? 10.sp),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          minimumSize: Size(size.width, size.height),
          maximumSize: Size(double.infinity, size.height),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 45.sp)),
          disabledBackgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8.sp)],
            Text(
              text.tr,
              style: bodyLarge(context).copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryOutlineButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final Widget? icon;
  final double? radius;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const PrimaryOutlineButton({
    required this.onPressed,
    this.text,
    this.icon,
    this.radius,
    this.textColor,
    this.width,
    this.height,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = this.borderColor ?? primaryColor;
    final Size size = Size(width ?? 100.sp, height ?? 55.sp);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: padding,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        side: BorderSide(color: borderColor),
        maximumSize: Size(double.infinity, size.height),
        minimumSize: Size(size.width, size.height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 10.sp)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 8.sp)],
          if (text != null) Text(text!.tr, style: bodyMedium(context).copyWith(color: textColor)),
        ],
      ),
    );
  }
}
