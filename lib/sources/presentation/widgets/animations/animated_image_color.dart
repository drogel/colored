import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/material.dart';

enum AnimatedImageColorState {
  beginColor,
  endColor,
}

class AnimatedImageColor extends StatelessWidget {
  const AnimatedImageColor(
    this.imagePath, {
    required this.begin,
    required this.end,
    required this.state,
    this.duration,
    this.size,
    this.curve,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final AnimatedImageColorState state;
  final Color begin;
  final Color end;
  final Duration? duration;
  final Curve? curve;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final durationScheme = DurationData.of(context)!.durationScheme;
    final curveScheme = CurveData.of(context)!.curveScheme;
    final defaultCurve = curveScheme.main;
    final defaultDuration = durationScheme.shortPresenting;
    final currentColor = _setCurrentColor();
    return TweenAnimationBuilder<Color>(
      tween: Tween<Color>(begin: begin, end: currentColor),
      duration: duration ?? defaultDuration,
      curve: curve ?? defaultCurve,
      builder: (context, color, child) => Image.asset(
        imagePath,
        height: size,
        width: size,
        color: color,
      ),
    );
  }

  Color _setCurrentColor() =>
      state == AnimatedImageColorState.beginColor ? begin : end;
}
