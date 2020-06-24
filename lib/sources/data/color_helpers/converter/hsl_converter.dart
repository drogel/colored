import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/material.dart';

class HslConverter implements Converter {
  const HslConverter();

  @override
  Map<Format, String> convert(int r, int g, int b) {
    final color = Color.fromRGBO(r, g, b, 1);
    final hslColor = HSLColor.fromColor(color);
    final hue = hslColor.hue.round();
    final saturation = (hslColor.saturation * percentFactor).round();
    final lightness = (hslColor.lightness * percentFactor).round();

    return {Format.hsl: "$hue°, $saturation%, $lightness%"};
  }
}