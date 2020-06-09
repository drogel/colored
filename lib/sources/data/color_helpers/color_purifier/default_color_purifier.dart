import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:flutter/material.dart';

class DefaultColorPurifier implements ColorPurifier {
  const DefaultColorPurifier();

  @override
  Color purify(Color color) {
    final hsvColor = HSVColor.fromColor(color);
    final pureColor = HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor();
    return pureColor;
  }
}