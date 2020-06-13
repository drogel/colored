import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:flutter/material.dart';

class DefaultColorPurifier implements ColorPurifier {
  const DefaultColorPurifier();

  @override
  Color purify(Color color) {
    final hsvColor = HSVColor.fromColor(color);
    final pureColor = getPureColorFromHue(hsvColor.hue);
    return pureColor;
  }

  @override
  double getHue(Color color) => HSVColor.fromColor(color).hue;

  @override
  Color getPureColorFromHue(double hue) =>
      HSVColor.fromAHSV(1, hue, 1, 1).toColor();
}
