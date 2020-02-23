import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data/color_selection.dart';
import 'package:flutter/foundation.dart';

const _kDecimal8Bit = 255;
const _kDecimalToHexModulo = 16;

class ConverterViewModel {
  const ConverterViewModel({
    @required StreamController<ConverterState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<ConverterState> _stateController;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState getInitialState() => const ConverterState(
        color: Color.fromRGBO(0, 0, 0, 1),
        rgbString: "0, 0, 0",
        hexString: "#000000",
      );

  void convertToColor(ColorSelection selection) {
    final red = (selection.firstComponent * _kDecimal8Bit).round();
    final green = (selection.secondComponent * _kDecimal8Bit).round();
    final blue = (selection.thirdComponent * _kDecimal8Bit).round();
    final color = Color.fromRGBO(red, green, blue, 1);
    final hexRed = _convertDecimalToHexString(red);
    final hexGreen = _convertDecimalToHexString(green);
    final hexBlue = _convertDecimalToHexString(blue);
    final rgbString = "$red, $green, $blue";
    final hexString = "#$hexRed$hexGreen$hexBlue";
    _stateController.sink.add(
      ConverterState(
        color: color,
        rgbString: rgbString,
        hexString: hexString,
      ),
    );
  }

  void dispose() => _stateController.close();

  String _convertDecimalToHexString(int decimal) =>
      decimal.toRadixString(_kDecimalToHexModulo).padLeft(2, "0").toUpperCase();
}
