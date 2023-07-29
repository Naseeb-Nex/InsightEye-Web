import 'package:flutter/material.dart';
import 'dart:math';

class ThreeCircularProgressBar extends StatelessWidget {
  final double strokeWidth;
  final int progress;
  final int completed;
  final int processing;
  final int pending;
  final int total;

  const ThreeCircularProgressBar({
    super.key,
    required this.strokeWidth,
    required this.progress,
    required this.completed,
    required this.processing,
    required this.pending,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleProgressBarPainter(
        strokeWidth: strokeWidth,
        total: total,
        progress: progress,
        completed: completed,
        processing: processing,
        pending: pending,
      ),
      child: SizedBox(
        width: 180,
        height: 180,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "$progress%",
                style: const TextStyle(
                  color: Color(0xFF363636),
                  fontSize: 25,
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      ),
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double strokeWidth;
  final int progress;
  final int completed;
  final int processing;
  final int pending;
  final int total;

  CircleProgressBarPainter({
    required this.strokeWidth,
    required this.progress,
    required this.completed,
    required this.processing,
    required this.pending,
    required this.total,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (strokeWidth / 2);

    // Section colors based on percentage thresholds
    final List<Color> sectionColors = [
      const Color(0XFFE7EAFC),
      const Color(0XFF01BAEF),
      const Color(0XFFE5383B),
      const Color(0XFF39DF2B),
    ];

    // Sweep angle for each section
    final List<double> sectionAngles = [
      -2 * pi * (100 - progress),
      -2 * pi * (processing/100),
      -2 * pi * (pending/100),
      -2 * pi * (completed/100),
    ];

    // Start angle for each section
    double startAngle = -pi / 2;

    for (int i = 0; i < sectionColors.length; i++) {
      final paint = Paint()
        ..color = sectionColors[i]
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Draw the progress arc with rounded edges
      final arcRect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(
        arcRect,
        startAngle,
        sectionAngles[i],
        false,
        paint,
      );

      // Update the start angle for the next section
      startAngle += sectionAngles[i];
    }
  }

  @override
  bool shouldRepaint(CircleProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
