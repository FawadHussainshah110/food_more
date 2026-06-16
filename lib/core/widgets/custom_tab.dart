import 'package:food_app_task/imports.dart';

class CustomTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final double? margin;

  const CustomTab({super.key, required this.label, this.selected = false, this.margin, required this.icon});

  @override
  Widget build(BuildContext context) {
    final tabState = selected
        ? SelectedTabState(label: label, icon: icon, margin: margin)
        : UnselectedTabState(label: label, icon: icon, margin: margin);

    return tabState.build(context);
  }
}

abstract class TabState {
  final String label;
  final IconData icon;
  final double? margin;

  TabState({required this.label, required this.icon, this.margin});

  Widget build(BuildContext context);
}

class SelectedTabState extends TabState {
  SelectedTabState({required super.label, required super.icon, super.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin ?? spacingExtraSmall),
      decoration: BoxDecoration(gradient: primaryGradientTopRightBottom, borderRadius: borderRadiusDefault),
      child: Padding(
        padding: EdgeInsets.all(1.5.sp),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spacingLarge - 1.5, vertical: spacingMedium - 1.5),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(borderRadiusDefault.topLeft.x - 1.5),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18.sp),
              SizedBox(width: spacingSmall),
              Text(
                label.tr,
                style: bodySmall(context).copyWith(color: secondaryColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnselectedTabState extends TabState {
  UnselectedTabState({required super.label, required super.icon, super.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin ?? spacingExtraSmall),
      padding: EdgeInsets.symmetric(horizontal: spacingLarge, vertical: spacingMedium),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: borderRadiusDefault,
        border: Border.all(color: context.theme.cardColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp),
          SizedBox(width: spacingSmall),
          Text(label.tr, style: bodySmall(context)),
        ],
      ),
    );
  }
}
