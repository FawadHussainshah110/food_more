// ignore_for_file: must_be_immutable

import '../../imports.dart';

Future showConfirmationDialog({
  required String title,
  required String subtitle,
  required String actionText,
  String? cancelText,
  required Function() onAccept,
}) {
  return showDialog(
    context: Get.context!,
    builder:
        (context) =>
            ConfirmationDialog(title: title, subtitle: subtitle, actionText: actionText, cancelText: cancelText, onAccept: onAccept),
  );
}

class ConfirmationDialog extends StatelessWidget {
  final String title, subtitle, actionText;
  String? cancelText;

  final Function() onAccept;
  ConfirmationDialog({
    required this.title,
    required this.subtitle,
    required this.actionText,
    this.cancelText,
    required this.onAccept,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: paddingDefault,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title.tr, style: bodyLarge(context).copyWith(fontWeight: FontWeight.w700)),
            Divider(height: spacingLarge),
            Text(subtitle.tr, textAlign: TextAlign.center, style: bodyMedium(context)),
            SizedBox(height: spacingLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: PrimaryButton(height: 45.sp, text: cancelText ?? 'cancel'.tr, radius: 10.sp, onPressed: pop)),
                SizedBox(width: spacingDefault),
                Expanded(child: PrimaryOutlineButton(height: 45.sp, text: actionText, onPressed: onAccept)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
