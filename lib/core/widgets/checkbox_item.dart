import 'package:food_app_task/imports.dart';

class CheckboxItem extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?) onChanged;

  const CheckboxItem({super.key, required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: context.theme.primaryColor,
          value: value,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.sp)),
        ),
        Expanded(child: Text(title, style: bodyMedium(context))),
      ],
    );
  }
}
