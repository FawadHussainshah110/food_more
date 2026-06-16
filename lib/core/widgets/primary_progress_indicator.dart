import 'package:food_app_task/imports.dart';

class PrimaryDotIndicator extends StatelessWidget {
  final int dotsLength;
  final int currentIndex;
  final double dotSize;
  final bool isCircular;
  const PrimaryDotIndicator({
    super.key,
    required this.dotsLength,
    required this.currentIndex,
    this.dotSize = 10,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotsLength,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: isCircular ? (dotSize + dotScaleCriculer(index)).sp : (dotSize + dotScale(index)).sp,
          height: dotSize.sp,
          margin: EdgeInsets.symmetric(horizontal: spacingExtraSmall),
          decoration: BoxDecoration(
            borderRadius: borderRadiusSmall,
            color: currentIndex == index
                ? context.theme.hintColor
                : isCircular
                ? context.theme.hintColor
                : context.theme.cardColor,
          ),
        ),
      ),
    );
  }

  double dotScale(index) => dotSize * (currentIndex == index ? 6 : 3);
  double dotScaleCriculer(index) => dotSize * (currentIndex == index ? 2 : 0);
}
