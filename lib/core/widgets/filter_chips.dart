import 'package:food_app_task/imports.dart';

class FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final Function(int) onFilterSelected;

  const FilterChips({super.key, required this.filters, required this.selectedIndex, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        itemCount: filters.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onFilterSelected(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.sp),
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 8.sp),
            decoration: BoxDecoration(
              color: selectedIndex == index ? context.theme.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(
                color: selectedIndex == index ? context.theme.primaryColor : context.theme.disabledColor,
              ),
            ),
            child: Center(
              child: Text(
                filters[index],
                style: bodyMedium(context).copyWith(
                  color: selectedIndex == index
                      ? context.theme.colorScheme.onPrimary
                      : context.theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
