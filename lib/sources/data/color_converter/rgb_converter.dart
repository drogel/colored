import 'dart:math';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_converter/color_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';

class RgbConverter implements ColorConverter {
  const RgbConverter();

  @override
  String convertToFormat(int r, int g, int b, Format format) {
    switch (format) {
      case Format.hex:
        return _convertToHex(r, g, b);
      case Format.rgb:
        return _convertToRgb(r, g, b);
      case Format.hsl:
        return _convertToHsl(r, g, b);
      case Format.hsv:
        return _convertToHsv(r, g, b);
    }
    return null;
  }

  String _convertToRgb(int r, int g, int b) => "$r, $g, $b";

  String _convertToHsl(int r, int g, int b) {
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

  String _convertToHex(int r, int g, int b) {
    final hexRed = _convertDecimalToHex(r);
    final hexGreen = _convertDecimalToHex(g);
    final hexBlue = _convertDecimalToHex(b);
    return "#$hexRed$hexGreen$hexBlue";
  }

  String _convertToHsv(int r, int g, int b) {
    final rf = r / decimal8Bit;
    final gf = g / decimal8Bit;
    final bf = b / decimal8Bit;
    final cMax = [rf, gf, bf].reduce(max);
    final cMin = [rf, gf, bf].reduce(min);
    final delta = cMax - cMin;
    num hue;
    num saturation = 0;
    num value = 0;

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

    if (cMax == 0) {
      saturation = 0;
    } else {
      saturation = (delta / cMax) * percentFactor;
      value = cMax * percentFactor;
    }

    hue = hue.round();
    saturation = saturation.round();
    value = value.round();

    return "$hue°, $saturation%, $value%";
  }

  String _convertDecimalToHex(int decimal) =>
      decimal.toRadixString(hexMod).padLeft(2, "0").toUpperCase();
}
