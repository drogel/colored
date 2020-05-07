import 'dart:async';

import 'package:colored/sources/data/color_helpers/color_converter/rgb_converter.dart';
import 'package:colored/sources/data/color_helpers/color_parser/color_parser.dart';
import 'package:colored/sources/data/color_helpers/color_transformer/color_transformer.dart';
import 'package:colored/sources/data/color_helpers/format_parser/hex_parser.dart';
import 'package:colored/sources/data/color_helpers/format_parser/hsl_parser.dart';
import 'package:colored/sources/data/color_helpers/format_parser/hsv_parser.dart';
import 'package:colored/sources/data/color_helpers/format_parser/rgb_parser.dart';
import 'package:colored/sources/data/services/device_orientation/system_chrome_service.dart';
import 'package:colored/sources/domain/data_models/format.dart';
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
          formatParsers: {
            Format.rgb: RgbParser(),
            Format.hex: HexParser(),
            Format.hsl: HslParser(),
            Format.hsv: HsvParser(),
          },
        ),
        colorConverter: const RgbConverter(),
        colorTransformer: const ColorTransformer(),
        deviceOrientationService: const SystemChromeService(),
      );
}
