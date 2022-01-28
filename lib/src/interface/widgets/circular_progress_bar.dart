import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class CircularProgressBar extends StatelessWidget {
  final double radius;
  final double progress;
  final Color? activeColor;
  final Color? inActiveColor;
  final double? trackWidth;
  final Widget? child;

  const CircularProgressBar({
    Key? key,
    required this.radius,
    required this.progress,
    this.activeColor,
    this.inActiveColor,
    this.trackWidth,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = radius * 2;
    double _height = radius * 2;

    return SizedBox(
      width: _width,
      height: _height,
      child: CustomPaint(
        painter: CircularProgressBarPainter(
          radius: radius,
          progress: progress,
          activeColor: activeColor ?? Theme.of(context).primaryColor,
          inActiveColor: inActiveColor ?? Theme.of(context).backgroundColor,
          trackWidth: trackWidth ?? 2.0,
        ),
        child: child,
        size: Size(
          _width,
          _height,
        ),
      ),
    );
  }
}

class CircularProgressBarPainter extends CustomPainter {
  final double radius;
  final double progress;
  final Color activeColor;
  final Color inActiveColor;
  final double trackWidth;

  const CircularProgressBarPainter({
    required this.radius,
    required this.progress,
    required this.activeColor,
    required this.inActiveColor,
    required this.trackWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = trackWidth
      ..strokeJoin = StrokeJoin.round
      ..color = inActiveColor;

    canvas.drawCircle(
      Offset(radius, radius),
      radius - trackWidth / 2,
      painter,
    );

    painter.color = activeColor;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius - trackWidth / 2,
      ),
      math.radians(-90),
      math.radians(360 * progress),
      false,
      painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
