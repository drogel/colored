import 'dart:math';

import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:colored/sources/common/factors.dart';

class HslConverter implements FormatConverter {
  const HslConverter();

  @override
  String convert(int r, int g, int b) {
    final rf = r / decimal8Bit;
    final gf = g / decimal8Bit;
    final bf = b / decimal8Bit;
    final cMax = [rf, gf, bf].reduce(max);
    final cMin = [rf, gf, bf].reduce(min);
    final delta = cMax - cMin;
    num hue;
    num saturation;
    num luminance;

    if (cMax == rf) {
      hue = 60 * ((gf - bf) / delta % 6);
    } else if (cMax == gf) {
      hue = 60 * ((bf - rf) / delta + 2);
    } else {
      hue = 60 * ((rf - gf) / delta + 4);
    }

    if (hue.isNaN || hue.isInfinite) {
      hue = 0;
    }

    luminance = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (luminance * 2 - 1).abs());
    }

    hue = hue.round();
    saturation = (saturation * percentFactor).round();
    luminance = (luminance * percentFactor).round();

    return "$hue°, $saturation%, $luminance%";
  }
}