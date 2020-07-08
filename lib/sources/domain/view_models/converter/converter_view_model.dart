import 'dart:async';
import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/parser/color_parser/parser.dart';
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter/foundation.dart';

class ConverterViewModel {
  const ConverterViewModel({
    @required StreamController<ConverterState> stateController,
    @required Parser colorParser,
    @required Converter colorConverter,
    @required DeviceOrientationService deviceOrientationService,
  })  : assert(stateController != null),
        assert(colorParser != null),
        assert(colorConverter != null),
        assert(deviceOrientationService != null),
        _deviceOrientationService = deviceOrientationService,
        _stateController = stateController,
        _converter = colorConverter,
        _parser = colorParser;

  final Parser _parser;
  final Converter _converter;
  final StreamController<ConverterState> _stateController;
  final DeviceOrientationService _deviceOrientationService;

  Stream<ConverterState> get stateStream => _stateController.stream;

  ConverterState get initialState {
    const initialColor = colors.primaryDark;
    return _convertToState(
      ColorSelection(
        r: initialColor.red.toDouble() / decimal8Bit,
        g: initialColor.green.toDouble() / decimal8Bit,
        b: initialColor.blue.toDouble() / decimal8Bit,
      ),
    );
  }

  void init() => _deviceOrientationService.setAllOrientations();

  void notifySelectionChanged(ColorSelection selection) {
    final state = _convertToState(selection);
    _stateController.sink.add(state);
  }

  void convertStringToColor(
    String string,
    Format format, {
    void Function(ColorSelection) onDone,
  }) {
    final selection = _parser.parseFromFormat(string, format);
    final state = _convertToState(selection);
    _stateController.sink.add(state);

    if (onDone != null) {
      onDone(selection);
    }
  }

  bool clipboardShouldFail(String string, Format format) =>
      !_parser.isStringOfFormat(string, format);

  void dispose() => _stateController.close();

  ConverterState _convertToState(ColorSelection selection) {
    final r = (selection.r * decimal8Bit).round();
    final g = (selection.g * decimal8Bit).round();
    final b = (selection.b * decimal8Bit).round();
    final formatData = _converter.convert(r, g, b);

    return ConverterState(formatData: formatData);
  }
}
