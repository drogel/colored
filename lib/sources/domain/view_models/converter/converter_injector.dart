import 'dart:async';

import 'package:colored/sources/data/color_parser/color_parser.dart';
import 'package:colored/sources/data/format_parser/hex_parser.dart';
import 'package:colored/sources/data/format_parser/hsl_parser.dart';
import 'package:colored/sources/data/format_parser/rgb_parser.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';

class ConverterInjector {
  const ConverterInjector();

  ConverterViewModel injectViewModel([
    StreamController<ConverterState> stateController,
  ]) =>
      ConverterViewModel(
        stateController: stateController ?? StreamController<ConverterState>(),
        colorParser: ColorParser(
          rgbParser: RgbParser(),
          hexParser: HexParser(),
          hslParser: HslParser(),
        ),
      );
}
