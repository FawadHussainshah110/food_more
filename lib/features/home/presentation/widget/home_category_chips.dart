import 'package:flutter/material.dart';
import 'package:food_app_task/imports.dart';

class HomeCategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const HomeCategoryChips({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(horizontal: spacingDefault),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: EdgeInsets.only(right: spacingSmall),
            child: ScaleBounceAnimation(
              onTap: () => onSelected(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: spacingMedium, vertical: spacingSmall),
                decoration: BoxDecoration(
                  color: isSelected ? context.theme.primaryColor : context.theme.cardColor,
                  borderRadius: borderRadiusLarge,
                  boxShadow: AppShadows.cardShadow,
                  border: Border.all(
                    color: isSelected ? context.theme.primaryColor : context.theme.disabledColor.withOpacity(0.15),
                    width: 1.sp
                  )
                ),
                child: Center(
                  child: Text(
                    category,
                    style: bodyMedium(context).copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? context.theme.colorScheme.onPrimary : context.theme.hintColor
                    )
                  )
                )
              )
            )
          );
        }
      )
    );
  }
}
