import 'dart:async';
import 'dart:ui';
import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/color_converter/color_converter.dart';
import 'package:colored/sources/data/color_helpers/color_parser/color_parser_type.dart';
import 'package:colored/sources/data/color_helpers/color_transformer/color_transformer_type.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

const _kConverterStep = 1 / decimal8Bit;
const _kTunedChangeFactor = 2;

class ConverterViewModel {
  const ConverterViewModel({
    @required StreamController<ConverterState> stateController,
    @required ColorParserType colorParser,
    @required ColorConverter colorConverter,
    @required ColorTransformerType colorTransformer,
  })  : assert(stateController != null),
        assert(colorParser != null),
        assert(colorTransformer != null),
        assert(colorConverter != null),
        _stateController = stateController,
        _converter = colorConverter,
        _transformer = colorTransformer,
        _parser = colorParser;

  final ColorParserType _parser;
  final ColorConverter _converter;
  final ColorTransformerType _transformer;
  final StreamController<ConverterState> _stateController;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState getInitialState() => _convertToState(
        ColorSelection(
          first: colors.primaryDark.red.toDouble() / decimal8Bit,
          second: colors.primaryDark.green.toDouble() / decimal8Bit,
          third: colors.primaryDark.blue.toDouble() / decimal8Bit,
        ),
      );

  void notifySelection(ColorSelection selection) {
    final state = _convertToState(selection);
    _stateController.sink.add(state);
  }

  void convertStringToColor(String string, Format format) {
    final selection = _parser.parseToFormat(string, format);
    notifySelection(selection);
  }

  bool clipboardShouldFail(String string, Format format) =>
      !_parser.isStringOfFormat(string, format);

  void rotateColor(double change, ColorSelection current) {
    final selection = _transformer.rotate(current, change);
    final state = _convertToState(selection);
    _stateController.sink.add(Shrinking.fromState(state));
  }

  void changeLightness(double change, ColorSelection current) {
    final tunedChange = change / _kTunedChangeFactor;
    final selection = _transformer.changeLightness(current, tunedChange);
    final state = _convertToState(selection);
    _stateController.sink.add(Shrinking.fromState(state));
  }

  void dispose() => _stateController.close();

  ConverterState _convertToState(ColorSelection selection) {
    final r = (selection.first * decimal8Bit).round();
    final g = (selection.second * decimal8Bit).round();
    final b = (selection.third * decimal8Bit).round();

    final color = Color.fromRGBO(r, g, b, 1);
    final rgbString = _converter.convertToFormat(r, g, b, Format.rgb);
    final hexString = _converter.convertToFormat(r, g, b, Format.hex);
    final hslString = _converter.convertToFormat(r, g, b, Format.hsl);
    final hsvString = _converter.convertToFormat(r, g, b, Format.hsv);
    return ConverterState(
      color: color,
      converterStep: _kConverterStep,
      selection: selection,
      formatData: {
        Format.hex: hexString,
        Format.rgb: rgbString,
        Format.hsl: hslString,
        Format.hsv: hsvString,
      },
    );
  }
}
