import 'package:flutter/material.dart';

class AppTourPainter extends CustomPainter {
  final Rect targetRect;

  AppTourPainter(this.targetRect);

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.7);

    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    final fullPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          targetRect.inflate(8),
          const Radius.circular(12),
        ),
      );

    canvas.drawPath(
      Path.combine(PathOperation.difference, fullPath, holePath),
      overlayPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(targetRect.inflate(8), const Radius.circular(12)),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
