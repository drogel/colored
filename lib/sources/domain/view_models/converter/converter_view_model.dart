import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:vector_math/vector_math.dart';
import 'package:colored/sources/domain/data_models/color_format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _kDecimal8Bit = 255;
const _kConverterStep = 1 / _kDecimal8Bit;
const _kDecimalToHexModulo = 16;
const _kTunedChangeFactor = 2;

final _hexRegExp = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
final _rgbRegExp = RegExp(
    r"^(rgb)?\(?([01]?\d\d?|2[0-4]\d|25[0-5])(\W+)([01]?\d\d?|2[0-4]\d|25"
    r"[0-5])\W+(([01]?\d\d?|2[0-4]\d|25[0-5])\)?)$");
final _doubleRegExp = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");

class ConverterViewModel {
  const ConverterViewModel({
    @required StreamController<ConverterState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<ConverterState> _stateController;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState getInitialState() => const ConverterState(
        color: Color.fromRGBO(0, 0, 0, 1),
        converterStep: 1 / _kDecimal8Bit,
        rgbString: "0, 0, 0",
        hexString: "#000000",
        selection: ColorSelection(
          first: 0,
          second: 0,
          third: 0,
        ),
      );

  void convertToColor(ColorSelection selection) {
    final red = (selection.first * _kDecimal8Bit).round();
    final green = (selection.second * _kDecimal8Bit).round();
    final blue = (selection.third * _kDecimal8Bit).round();
    final color = Color.fromRGBO(red, green, blue, 1);
    final hexRed = _convertDecimalToHexString(red);
    final hexGreen = _convertDecimalToHexString(green);
    final hexBlue = _convertDecimalToHexString(blue);
    final rgbString = "$red, $green, $blue";
    final hexString = "#$hexRed$hexGreen$hexBlue";
    _stateController.sink.add(
      ConverterState(
        color: color,
        converterStep: _kConverterStep,
        rgbString: rgbString,
        hexString: hexString,
        selection: selection,
      ),
    );
  }

  void convertStringToColor(String string, ColorFormat colorFormat) {
    switch (colorFormat) {
      case ColorFormat.hex:
        final selection = _parseHex(string);
        return convertToColor(selection);
      case ColorFormat.rgb:
        final selection = _parseRgb(string);
        return convertToColor(selection);
    }
  }

  bool clipboardShouldFail(String string, ColorFormat colorFormat) =>
      !_isStringColorFormat(string, colorFormat);

  void rotateColor(double change, ColorSelection currentSelection) {
    final m = Matrix3.identity();
    final cosA = cos(radians(change));
    final sinA = sin(radians(change));
    final arg0 = cosA + (1.0 - cosA) / 3.0;
    final arg1 = 1.0 / 3.0 * (1.0 - cosA) - sqrt(1.0 / 3.0) * sinA;
    final arg2 = 1.0 / 3.0 * (1.0 - cosA) + sqrt(1.0 / 3.0) * sinA;
    final arg3 = 1.0 / 3.0 * (1.0 - cosA) + sqrt(1.0 / 3.0) * sinA;
    final arg4 = cosA + 1.0 / 3.0 * (1.0 - cosA);
    final arg5 = 1.0 / 3.0 * (1.0 - cosA) - sqrt(1.0 / 3.0) * sinA;
    final arg6 = 1.0 / 3.0 * (1.0 - cosA) - sqrt(1.0 / 3.0) * sinA;
    final arg7 = 1.0 / 3.0 * (1.0 - cosA) + sqrt(1.0 / 3.0) * sinA;
    final arg8 = cosA + 1.0 / 3.0 * (1.0 - cosA);
    m.setValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);

    final r = _kDecimal8Bit * currentSelection.first;
    final g = _kDecimal8Bit *currentSelection.second;
    final b = _kDecimal8Bit * currentSelection.third;
    final rx = r * m.entry(0, 0) + g * m.entry(0, 1) + b * m.entry(0, 2);
    final gx = r * m.entry(1, 0) + g * m.entry(1, 1) + b * m.entry(1, 2);
    final bx = r * m.entry(2, 0) + g * m.entry(2, 1) + b * m.entry(2, 2);

    final selection = ColorSelection(
      first: rx.clamp(0, _kDecimal8Bit) / _kDecimal8Bit,
      second: gx.clamp(0, _kDecimal8Bit) / _kDecimal8Bit,
      third: bx.clamp(0, _kDecimal8Bit) / _kDecimal8Bit,
    );
    convertToColor(selection);
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
    convertToColor(selection);
  }

  void dispose() => _stateController.close();

  ColorSelection _parseRgb(String string) {
    final rgbMatchedString = _rgbRegExp.firstMatch(string).group(0);
    final rgbStringRemovingSeparators = rgbMatchedString
        .replaceAll(",", " ")
        .replaceAll("-", " ")
        .replaceAll("/", " ");
    final rgbComponents = _doubleRegExp
        .allMatches(rgbStringRemovingSeparators)
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

  String _convertDecimalToHexString(int decimal) =>
      decimal.toRadixString(_kDecimalToHexModulo).padLeft(2, "0").toUpperCase();

  bool _isHex(String string) => _hexRegExp.hasMatch(string);

  bool _isRgb(String string) => _rgbRegExp.hasMatch(string);

  bool _isStringColorFormat(String string, ColorFormat colorFormat) {
    switch (colorFormat) {
      case ColorFormat.hex:
        return _isHex(string);
      case ColorFormat.rgb:
        return _isRgb(string);
    }
    return false;
  }
}
