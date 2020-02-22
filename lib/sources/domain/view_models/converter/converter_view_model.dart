import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data/color_selection.dart';
import 'package:flutter/foundation.dart';

const _kDecimal8Bit = 255;

class ConverterViewModel {
  const ConverterViewModel({
    @required StreamController<ConverterState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<ConverterState> _stateController;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState getInitialState() => const ConverterState(
        color: Color.fromRGBO(150, 150, 150, 1),
        rgbComponents: "150, 150, 150",
      );

  void convertToColor(ColorSelection selection) {
    final red = (selection.firstComponent * _kDecimal8Bit).round();
    final green = (selection.secondComponent * _kDecimal8Bit).round();
    final blue = (selection.thirdComponent * _kDecimal8Bit).round();
    final color = Color.fromRGBO(red, green, blue, 1);
    final rgbString = "$red, $green, $blue";
    _stateController.sink.add(
      ConverterState(
        color: color,
        rgbComponents: rgbString,
      ),
    );
  }

  void dispose() => _stateController.close();
}
