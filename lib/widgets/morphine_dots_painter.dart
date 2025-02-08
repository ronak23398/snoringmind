import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

// Add this custom painter for the morphing animation
class MorphingDotsPainter extends CustomPainter {
  final double animationValue;
  final List<Color> colors;

  MorphingDotsPainter(this.animationValue, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    final dotCount = 4;
    final spacing = size.width / (dotCount + 1);

    for (int i = 0; i < dotCount; i++) {
      final startX = spacing * (i + 1);
      final nextX = spacing * (i + 2);

      // Create morphing effect
      final morphProgress = (animationValue - (i * 0.2)).clamp(0.0, 1.0);
      final lineProgress = (morphProgress * 2 - 1).clamp(0.0, 1.0);

      // Color interpolation
      final colorIndex = i % colors.length;
      final nextColorIndex = (i + 1) % colors.length;
      final color = Color.lerp(
        colors[colorIndex],
        colors[nextColorIndex],
        morphProgress,
      )!;
      paint.color = color;

      // Draw dots and lines
      if (morphProgress < 0.5) {
        // Draw expanding dot
        final radius = 3 + (morphProgress * 2);
        canvas.drawCircle(Offset(startX, size.height / 2), radius, paint);
      } else {
        // Draw line
        final startPoint = Offset(startX, size.height / 2);
        final endPoint = Offset(
          startX + (nextX - startX) * lineProgress,
          size.height / 2,
        );
        canvas.drawLine(startPoint, endPoint, paint);
      }
    }
  }

  @override
  bool shouldRepaint(MorphingDotsPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
