import 'dart:async';
import 'dart:ui';
import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/color_converter/converter.dart';
import 'package:colored/sources/data/color_helpers/color_parser/parser.dart';
import 'package:colored/sources/data/color_helpers/color_transformer/transformer.dart';
import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
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
    @required Parser colorParser,
    @required Converter colorConverter,
    @required Transformer colorTransformer,
    @required DeviceOrientationService deviceOrientationService,
  })  : assert(stateController != null),
        assert(colorParser != null),
        assert(colorTransformer != null),
        assert(colorConverter != null),
        assert(deviceOrientationService != null),
        _deviceOrientationService = deviceOrientationService,
        _stateController = stateController,
        _converter = colorConverter,
        _transformer = colorTransformer,
        _parser = colorParser;

  final Parser _parser;
  final Converter _converter;
  final Transformer _transformer;
  final StreamController<ConverterState> _stateController;
  final DeviceOrientationService _deviceOrientationService;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState get initialData => _convertToState(
        ColorSelection(
          first: colors.primaryDark.red.toDouble() / decimal8Bit,
          second: colors.primaryDark.green.toDouble() / decimal8Bit,
          third: colors.primaryDark.blue.toDouble() / decimal8Bit,
        ),
      );

  void init() => _deviceOrientationService.setAllOrientations();

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

    final formatData = {
      for (var format in Format.values)
        format: _converter.convertToFormat(r, g, b, format)
    };

    return ConverterState(
      color: Color.fromRGBO(r, g, b, 1),
      converterStep: _kConverterStep,
      selection: selection,
      formatData: formatData,
    );
  }
}
