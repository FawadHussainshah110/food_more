import 'package:food_app_task/imports.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  const DottedDivider({
    super.key,
    this.height = 2,
    this.width = double.infinity,
    this.color,
    this.dashWidth = 5,
    this.dashGap = 3,
    this.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        painter: _DottedLinePainter(
          // ignore: deprecated_member_use
          color: color ?? context.theme.hintColor.withOpacity(0.3),
          dashWidth: dashWidth,
          dashGap: dashGap,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  _DottedLinePainter({required this.color, required this.dashWidth, required this.dashGap, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double currentX = 0;
    final y = size.height / 2;

    while (currentX < size.width) {
      canvas.drawLine(Offset(currentX, y), Offset(currentX + dashWidth, y), paint);
      currentX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dashWidth != dashWidth ||
      oldDelegate.dashGap != dashGap ||
      oldDelegate.strokeWidth != strokeWidth;
}
