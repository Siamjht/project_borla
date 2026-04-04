
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';


class CustomLoader extends StatefulWidget {
  final double size;
  final Color? color;
  final List<Color>? gradientColors;

  const CustomLoader({
    super.key,
    this.size = 40,
    this.color,
    this.gradientColors,
  });

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ── Resolve colors ──
    final colors = widget.gradientColors ??
        (widget.color != null
            ? [widget.color!, widget.color!]
            : [AppColors.orange500, AppColors.green500]);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ArcPainter(
              progress: _controller.value,
              gradientColors: colors,
            ),
          ),
        );
      },
    );
  }
}

// ── Painter ──
class _ArcPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;

  _ArcPainter({
    required this.progress,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 4;

    // ── Track ──
    final trackPaint = Paint()
      ..color = gradientColors.first.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, radius, trackPaint);

    // ── Gradient Arc ──
    final rect = Rect.fromCircle(center: center, radius: radius);

    final arcPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          gradientColors.first.withValues(alpha: 0.0),
          gradientColors.first,
          gradientColors.last,
        ],
        stops: const [0.0, 0.5, 1.0],
        startAngle: 0,
        endAngle: 2 * pi,
        transform: GradientRotation(progress * 2 * pi - pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -pi / 2 + (progress * 2 * pi),  // start angle
      -(pi * 1.7),                      // ✅ sweep angle — negative for smooth tail
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}