import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_track.dart';
import 'package:flutter/material.dart';

class HslTrack extends StatelessWidget {
  const HslTrack({
    @required this.hue,
    Key key,
  }) : super(key: key);

  final double hue;

  @override
  Widget build(BuildContext context) => HueBasedTrack(
        painter: _HSLColorPainter(
          color: HSLColor.fromAHSL(1, hue, 1, 0.5).toColor(),
        ),
      );
}

class _HSLColorPainter extends CustomPainter {
  const _HSLColorPainter({
    @required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const verticalGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.white,
        Colors.transparent,
        Colors.transparent,
        Colors.black,
      ],
    );
    final horizontalGradient = LinearGradient(
      colors: [const Color(0xff808080), color],
    );
    final vPaint = Paint()..shader = verticalGradient.createShader(rect);
    final hPaint = Paint()..shader = horizontalGradient.createShader(rect);

    canvas.drawRect(rect, hPaint);
    canvas.drawRect(rect, vPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
