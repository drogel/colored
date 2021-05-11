import 'package:colored/sources/common/factors.dart' as factors;
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_track.dart';
import 'package:flutter/material.dart';

const _kDegreesPerHueDivision = 60.0;

class HueTrack extends StatelessWidget {
  const HueTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const HueBasedTrack(
        painter: _HueColorPainter(),
      );
}

class _HueColorPainter extends CustomPainter {
  const _HueColorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final colors = List<Color>.generate(
      factors.degreesInTurn ~/ _kDegreesPerHueDivision + 1,
      _colorBuilder,
    );
    Gradient gradient = LinearGradient(colors: colors);
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  Color _colorBuilder(int index) {
    final hue = _kDegreesPerHueDivision * index % factors.degreesInTurn;
    return HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }
}
