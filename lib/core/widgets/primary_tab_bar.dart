import 'package:food_app_task/core/widgets/custom_tab.dart';
import 'package:food_app_task/imports.dart';

class PrimaryTabBar extends StatelessWidget {
  final List<String> tabLabels;
  final List<IconData> icons;
  final int currentIndex;
  final Function(int) onTabChanged;

  const PrimaryTabBar({
    super.key,
    required this.tabLabels,
    required this.currentIndex,
    required this.onTabChanged,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.sp,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: spacingSmall, vertical: spacingExtraSmall),
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            tabLabels.length,
            (index) => GestureDetector(
              onTap: () => onTabChanged(index),
              child: CustomTab(
                label: tabLabels[index],
                selected: currentIndex == index,
                icon: icons[index],
                margin: spacingExtraSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
