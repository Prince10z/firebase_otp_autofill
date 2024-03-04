import 'dart:math';

import 'package:flutter/material.dart';

class CountdownPainter extends CustomPainter {
  final double progress;

  CountdownPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purple.shade900 // Keep the color constant as red
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    double radius = min(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw a full circle in red
    canvas.drawCircle(center, radius, paint);

    // Draw an arc based on the remaining progress in green
    paint.color = Colors.purple.shade100;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // start at the top
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
