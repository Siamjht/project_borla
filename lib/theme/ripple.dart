import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  const RippleAnimation({super.key});

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RipplePainter(_controller),
      size: const Size(100, 100),
    );
  }
}


class RipplePainter extends CustomPainter {
  final Animation<double> animation;

  RipplePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    final paint = Paint()
     // ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final progress = (animation.value + i / 3) % 1;
      final radius = maxRadius * progress;
      final opacity = (1 - progress).clamp(0.0, 1.0);

      //paint.color = Colors.red.withOpacity(opacity);

      paint.shader = RadialGradient(
        colors: [
          Color.fromRGBO(255, 214, 0, 1),
          Color.fromRGBO(255,149,0, 1),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, paint);
    }

    /// Center dot
    /// Center dot (radiant / glowing)
    final double glowRadius = 12 + 4 * animation.value;

    final Paint centerPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          // Colors.orangeAccent,
          // Colors.orange.withOpacity(0.6),
          // Colors.amber,
          Color.fromRGBO(255, 214, 0, 1),
          Colors.orange.withOpacity(0.6),
          Color.fromRGBO(255,149,0, 1),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: glowRadius),

      );

    canvas.drawCircle(center, 8, centerPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
