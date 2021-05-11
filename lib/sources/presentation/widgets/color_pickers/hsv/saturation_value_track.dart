import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_track.dart';
import 'package:flutter/material.dart';

class SaturationValueTrack extends StatelessWidget {
  const SaturationValueTrack({
    required this.hue,
    Key? key,
  }) : super(key: key);

  final double hue;

  @override
  Widget build(BuildContext context) => HueBasedTrack(
        painter: _SaturationValuePainter(
          color: HSVColor.fromAHSV(1, hue, 1, 1).toColor(),
        ),
      );
}

class _SaturationValuePainter extends CustomPainter {
  const _SaturationValuePainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const verticalGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.black],
    );
    final horizontalGradient = LinearGradient(
      colors: [Colors.white, color],
    );
    final verticalPaint = Paint()..shader = verticalGradient.createShader(rect);
    final horizontalPaint = Paint()
      ..blendMode = BlendMode.multiply
      ..shader = horizontalGradient.createShader(rect);

    canvas.drawRect(rect, verticalPaint);
    canvas.drawRect(rect, horizontalPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
