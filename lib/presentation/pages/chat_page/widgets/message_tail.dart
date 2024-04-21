import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final bool isSender;
  TrianglePainter(
      {this.strokeColor = const Color(0xfffe5151),
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.fill,
      required this.isSender});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isSender
          ? const Color(0xfffe5151)
          : const Color.fromARGB(255, 218, 236, 249)
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    Path pathright = Path()
      ..moveTo(2, y)
      ..lineTo(x / 5, 0)
      ..lineTo(x, 1)
      ..lineTo(1, y);
    Path pathleft = Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, 17)
      ..lineTo(2, y);
    return isSender ? pathright : pathleft;
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
