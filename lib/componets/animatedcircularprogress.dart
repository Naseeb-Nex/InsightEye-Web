import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgressBarPainter extends CustomPainter {
  final double strokeWidth;
  final double progress;
  final double rotationValue;

  CircleProgressBarPainter({
    required this.strokeWidth,
    required this.progress,
    required this.rotationValue,
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
      -2 * pi * ((100 - progress) / 100),
      -2 * pi * (min(progress, 33) / 100),
      -2 * pi * ((min(progress, 66) - 33) / 100),
      -2 * pi * ((min(progress, 100) - 66) / 100),
    ];

    // Start angle for each section (to flip from left-to-right to right-to-left)
    double currentStartAngle = rotationValue * 2 * pi - pi / 2;

    for (int i = 0; i < sectionColors.length; i++) {
      final paint = Paint()
        ..color = sectionColors[i]
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Draw the progress arc with rounded edges and apply rotation transformation
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(currentStartAngle);
      canvas.translate(-center.dx, -center.dy);

      final arcRect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(
        arcRect,
        0,
        sectionAngles[i],
        false,
        paint,
      );

      canvas.restore();

      // Update the start angle for the next section
      currentStartAngle += sectionAngles[i];
    }
  }

  @override
  bool shouldRepaint(CircleProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.rotationValue != rotationValue;
  }
}

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Set the duration of the animation
    );

    // Add a listener to the controller to repeat the animation on completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    // Start the animation when the widget is first built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CircleProgressBarPainter(
            strokeWidth: 21,
            progress: 80,
            rotationValue: _controller.value, // Pass the animation value here
          ),
          size: const Size(200, 200),
        );
      },
    );
  }
}
