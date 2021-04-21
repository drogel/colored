import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

class HslParser extends FormatParser {
  final _hslRegExp = RegExp(r"^(hsl)?\(?\s*(\d+)\s*(°)?(\W+)"
      r"\s*(\d*(?:\.\d+)?(%)?)\s*(\W+)\s*(\d*(?:\.\d+)?(%)?)\)?");

  @override
  bool hasMatch(String? input) {
    if (input == null) {
      return false;
    }
    return _hslRegExp.hasMatch(input);
  }

  @override
  ColorSelection parse(String string) {
    assert(string.isNotEmpty, 'String color format to parse cannot be empty');
    final hslMatches = _hslRegExp.firstMatch(string);
    if (hslMatches == null) {
      throw ArgumentError("String can't be parsed to HSL");
    }
    final hslMatched = hslMatches.group(0);
    if (hslMatched == null) {
      throw ArgumentError("String can't be parsed to HSL");
    }

    final hslComponents = getDoubleComponents(hslMatched);
    var rgb = <double>[0, 0, 0];

    final hue = hslComponents[0] / degreesInTurn % 1;
    final saturation = hslComponents[1] / percentFactor;
    final luminance = hslComponents[2] / percentFactor;

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

    return ColorSelection(r: rgb[0], g: rgb[1], b: rgb[2]);
  }
}
