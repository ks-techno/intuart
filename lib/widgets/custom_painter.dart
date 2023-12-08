import 'package:flutter/material.dart';

class DottedScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    const gap = 40;

    for (double i = 0; i < size.width; i += gap) {
      for (double j = 0; j < size.height; j += gap) {
        canvas.drawCircle(Offset(i, j), 5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}