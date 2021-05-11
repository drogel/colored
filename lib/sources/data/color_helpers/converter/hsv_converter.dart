import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/material.dart';

class HsvConverter implements Converter {
  const HsvConverter();

  @override
  Map<Format, String> convert(int r, int g, int b) {
    final color = Color.fromRGBO(r, g, b, 1);
    final hsvColor = HSVColor.fromColor(color);
    final hue = hsvColor.hue.round();
    final saturation = (hsvColor.saturation * percentFactor).round();
    final value = (hsvColor.value * percentFactor).round();
    return {Format.hsv: "$hue°, $saturation%, $value%"};
  }
}
