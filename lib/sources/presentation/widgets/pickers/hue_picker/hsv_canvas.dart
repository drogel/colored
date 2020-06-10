import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:flutter/material.dart';

class HsvCanvas extends StatelessWidget {
  const HsvCanvas({
    @required this.color,
    this.purifier = const DefaultColorPurifier(),
    Key key,
  })  : assert(color != null),
        assert(purifier != null),
        super(key: key);

  final ColorPurifier purifier;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _HSVColorPainter(
          purifier: purifier,
          color: color,
        ),
      );
}

class _HSVColorPainter extends CustomPainter {
  const _HSVColorPainter({
    @required this.purifier,
    @required this.color,
  });

  final ColorPurifier purifier;
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
      colors: [Colors.white, purifier.purify(color)],
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
