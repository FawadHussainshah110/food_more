import 'package:food_app_task/imports.dart';

class FloatingBackgroundEmoji extends StatelessWidget {
  final String emoji;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Duration delay;
  final double slideOffset;
  final double fontSize;

  const FloatingBackgroundEmoji({
    super.key,
    required this.emoji,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.delay,
    required this.slideOffset,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: FadeSlideAnimation(
        delay: delay,
        slideOffset: slideOffset,
        child: Text(emoji, style: TextStyle(fontSize: fontSize.sp)),
      ),
    );
  }
}
