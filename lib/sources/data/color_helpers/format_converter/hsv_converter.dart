import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:flutter/material.dart';

class HsvConverter implements FormatConverter {
  const HsvConverter();

  @override
  String convert(int r, int g, int b) {
    final color = Color.fromRGBO(r, g, b, 1);
    final hsvColor = HSVColor.fromColor(color);
    final hue = hsvColor.hue.round();
    final saturation = (hsvColor.saturation * percentFactor).round();
    final value = (hsvColor.value * percentFactor).round();

    return "$hue°, $saturation%, $value%";
  }
}
