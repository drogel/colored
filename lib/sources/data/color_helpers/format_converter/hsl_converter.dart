import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:colored/sources/common/factors.dart';
import 'package:flutter/material.dart';

class HslConverter implements FormatConverter {
  const HslConverter();

  @override
  String convert(int r, int g, int b) {
    final color = Color.fromRGBO(r, g, b, 1);
    final hslColor = HSLColor.fromColor(color);
    final hue = hslColor.hue.round();
    final saturation = (hslColor.saturation * percentFactor).round();
    final lightness = (hslColor.lightness * percentFactor).round();

    return "$hue°, $saturation%, $lightness%";
  }
}