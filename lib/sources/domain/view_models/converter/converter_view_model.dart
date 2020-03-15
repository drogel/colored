import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:vector_math/vector_math.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/extensions/string_replace_non_alphanumeric.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

const _kDecimal8Bit = 255;
const _kConverterStep = 1 / _kDecimal8Bit;
const _kDecimalToHexModulo = 16;
const _kTunedChangeFactor = 2;

final _hexRegExp = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
final _rgbRegExp = RegExp(
    r"^(rgb)?\(?([01]?\d\d?|2[0-4]\d|25[0-5])(\W+)([01]?\d\d?|2[0-4]\d|25"
    r"[0-5])\W+(([01]?\d\d?|2[0-4]\d|25[0-5])\)?)$");
final _hslRegExp = RegExp(r"^(hsl)?\(?\s*(\d+)\s*(°)?(\W+)"
    r"\s*(\d*(?:\.\d+)?(%)?)\s*(\W+)\s*(\d*(?:\.\d+)?(%)?)\)?");
final _doubleRegExp = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");

class ConverterViewModel {
  const ConverterViewModel({
    @required StreamController<ConverterState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<ConverterState> _stateController;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState getInitialState() => _convertToState(
        const ColorSelection(first: 0, second: 0, third: 0),
      );

  void notifySelection(ColorSelection selection) {
    final state = _convertToState(selection);
    _stateController.sink.add(state);
  }

  void convertStringToColor(String string, Format colorFormat) {
    switch (colorFormat) {
      case Format.hex:
        final selection = _parseHex(string);
        return notifySelection(selection);
      case Format.rgb:
        final selection = _parseRgb(string);
        return notifySelection(selection);
      case Format.hsl:
        final selection = _parseHsl(string);
        return notifySelection(selection);
    }
  }

  bool clipboardShouldFail(String string, Format colorFormat) =>
      !_isStringColorFormat(string, colorFormat);

  void rotateColor(double change, ColorSelection currentSelection) {
    final m = Matrix3.identity();
    final cosA = cos(radians(change));
    final sinA = sin(radians(change));
    final arg0 = cosA + (1 - cosA) / 3;
    final arg1 = 1 / 3 * (1 - cosA) - sqrt(1 / 3) * sinA;
    final arg2 = 1 / 3 * (1 - cosA) + sqrt(1 / 3) * sinA;
    final arg3 = 1 / 3 * (1 - cosA) + sqrt(1 / 3) * sinA;
    final arg4 = cosA + 1 / 3 * (1 - cosA);
    final arg5 = 1 / 3 * (1 - cosA) - sqrt(1 / 3) * sinA;
    final arg6 = 1 / 3 * (1 - cosA) - sqrt(1 / 3) * sinA;
    final arg7 = 1 / 3 * (1 - cosA) + sqrt(1 / 3) * sinA;
    final arg8 = cosA + 1 / 3 * (1 - cosA);
    m.setValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);

    final r = _kDecimal8Bit * currentSelection.first;
    final g = _kDecimal8Bit * currentSelection.second;
    final b = _kDecimal8Bit * currentSelection.third;
    final rx = r * m.entry(0, 0) + g * m.entry(0, 1) + b * m.entry(0, 2);
    final gx = r * m.entry(1, 0) + g * m.entry(1, 1) + b * m.entry(1, 2);
    final bx = r * m.entry(2, 0) + g * m.entry(2, 1) + b * m.entry(2, 2);

    final selection = ColorSelection(
      first: rx.clamp(0, _kDecimal8Bit) / _kDecimal8Bit,
      second: gx.clamp(0, _kDecimal8Bit) / _kDecimal8Bit,
      third: bx.clamp(0, _kDecimal8Bit) / _kDecimal8Bit,
    );

    final state = _convertToState(selection);
    _stateController.sink.add(Shrinking.fromState(state));
  }

  void changeLightness(double change, ColorSelection current) {
    final tunedChange = change / _kTunedChangeFactor;
    final red = (current.first * _kDecimal8Bit + tunedChange)
        .round()
        .clamp(0, _kDecimal8Bit);
    final green = (current.second * _kDecimal8Bit + tunedChange)
        .round()
        .clamp(0, _kDecimal8Bit);
    final blue = (current.third * _kDecimal8Bit + tunedChange)
        .round()
        .clamp(0, _kDecimal8Bit);
    final selection = ColorSelection(
      first: red / _kDecimal8Bit,
      second: green / _kDecimal8Bit,
      third: blue / _kDecimal8Bit,
    );
    final state = _convertToState(selection);
    _stateController.sink.add(Shrinking.fromState(state));
  }

  void dispose() => _stateController.close();

  ColorSelection _parseRgb(String string) {
    final rgbMatched = _rgbRegExp.firstMatch(string).group(0);
    final rgbWithoutSeparators = rgbMatched.replacingAllNonAlphanumericBy(" ");
    final rgbComponents = _doubleRegExp
        .allMatches(rgbWithoutSeparators)
        .map((match) => double.parse(match.group(0)))
        .toList();

    final selection = ColorSelection(
      first: rgbComponents[0] / _kDecimal8Bit,
      second: rgbComponents[1] / _kDecimal8Bit,
      third: rgbComponents[2] / _kDecimal8Bit,
    );
    return selection;
  }

  ColorSelection _parseHex(String string) {
    final buffer = StringBuffer();
    if (string.length == 6 || string.length == 7) {
      buffer.write('ff');
    }
    buffer.write(string.replaceFirst('#', ''));
    final color = Color(int.parse(buffer.toString(), radix: 16));
    final selection = ColorSelection(
      first: color.red / _kDecimal8Bit,
      second: color.green / _kDecimal8Bit,
      third: color.blue / _kDecimal8Bit,
    );
    return selection;
  }

  ColorSelection _parseHsl(String string) {
    final hslMatched = _hslRegExp.firstMatch(string).group(0);
    final hslWithoutSeparators = hslMatched.replacingAllNonAlphanumericBy(" ");
    final hslComponents = _doubleRegExp
        .allMatches(hslWithoutSeparators)
        .map((match) => double.parse(match.group(0)))
        .toList();
    var rgb = <double>[0, 0, 0];

    final hue = hslComponents[0] / 360 % 1;
    final saturation = hslComponents[1] / 100;
    final luminance = hslComponents[2] / 100;

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb = rgb.map((val) => val + (1 - saturation) * (0.5 - val)).toList();

    if (luminance < 0.5) {
      rgb = rgb.map((val) => luminance * 2 * val).toList();
    } else {
      rgb = rgb.map((val) => luminance * 2 * (1 - val) + 2 * val - 1).toList();
    }

    return ColorSelection(first: rgb[0], second: rgb[1], third: rgb[2]);
  }

  String _convertDecimalToHexString(int decimal) =>
      decimal.toRadixString(_kDecimalToHexModulo).padLeft(2, "0").toUpperCase();

  bool _isHex(String string) => _hexRegExp.hasMatch(string);

  bool _isRgb(String string) => _rgbRegExp.hasMatch(string);

  bool _isHsl(String string) => _hslRegExp.hasMatch(string);

  bool _isStringColorFormat(String string, Format colorFormat) {
    switch (colorFormat) {
      case Format.hex:
        return _isHex(string);
      case Format.rgb:
        return _isRgb(string);
      case Format.hsl:
        return _isHsl(string);
    }
    return false;
  }

  String _convertRgbToHslString(int r, int g, int b) {
    final rf = r / 255;
    final gf = g / 255;
    final bf = b / 255;
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
    saturation = (saturation * 100).round();
    luminance = (luminance * 100).round();

    return "$hueº, $saturation%, $luminance%";
  }

  ConverterState _convertToState(ColorSelection selection) {
    final red = (selection.first * _kDecimal8Bit).round();
    final green = (selection.second * _kDecimal8Bit).round();
    final blue = (selection.third * _kDecimal8Bit).round();
    final color = Color.fromRGBO(red, green, blue, 1);
    final hexRed = _convertDecimalToHexString(red);
    final hexGreen = _convertDecimalToHexString(green);
    final hexBlue = _convertDecimalToHexString(blue);
    final rgbString = "$red, $green, $blue";
    final hexString = "#$hexRed$hexGreen$hexBlue";
    final hslString = _convertRgbToHslString(red, green, blue);
    return ConverterState(
      color: color,
      converterStep: _kConverterStep,
      selection: selection,
      formatData: {
        Format.hex: hexString,
        Format.rgb: rgbString,
        Format.hsl: hslString,
      },
    );
  }
}
