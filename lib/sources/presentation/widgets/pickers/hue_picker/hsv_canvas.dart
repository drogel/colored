import 'package:colored/sources/presentation/widgets/pickers/hue_picker/hue_canvas.dart';
import 'package:flutter/material.dart';

class HsvCanvas extends HueCanvas {
  const HsvCanvas({
    @required double hue,
    Key key,
  }) : super(hue: hue, key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _HSVColorPainter(
          color: HSVColor.fromAHSV(1, hue, 1, 1).toColor(),
        ),
      );
}

class _HSVColorPainter extends CustomPainter {
  const _HSVColorPainter({
    @required this.color,
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
