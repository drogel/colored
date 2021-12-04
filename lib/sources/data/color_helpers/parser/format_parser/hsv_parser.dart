import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

class HsvParser extends FormatParser {
  final _hsvRegExp = RegExp(r"^(hsv)?\(?\s*(\d+)\s*(°)?(\W+)"
      r"\s*(\d*(?:\.\d+)?(%)?)\s*(\W+)\s*(\d*(?:\.\d+)?(%)?)\)?");

  @override
  bool hasMatch(String? input) {
    if (input == null) {
      return false;
    }
    return _hsvRegExp.hasMatch(input);
  }

  @override
  ColorSelection parse(String string) {
    assert(string.isNotEmpty, "String color format to parse cannot be empty");
    final hsvMatched = _hsvRegExp.firstMatch(string)?.group(0);
    if (hsvMatched == null) {
      throw ArgumentError("String can't be parsed to HSV");
    }

    final hsvComponents = getDoubleComponents(hsvMatched);
    var rgb = <double>[0, 0, 0];

    final hue = hsvComponents[0];
    final saturation = hsvComponents[1] / percentFactor;
    final value = hsvComponents[2] / percentFactor;

    final hue60 = hue / 60;
    final hue60Floored = hue60.floor();
    final h = hue60Floored % 6;
    final f = hue60 - hue60Floored;

    final p = value * (1 - saturation);
    final q = value * (1 - f * saturation);
    final t = value * (1 - (1 - f) * saturation);

    if (h == 0) {
      rgb = [value, t, p];
    } else if (h == 1) {
      rgb = [q, value, p];
    } else if (h == 2) {
      rgb = [p, value, t];
    } else if (h == 3) {
      rgb = [p, q, value];
    } else if (h == 4) {
      rgb = [t, p, value];
    } else if (h == 5) {
      rgb = [value, p, q];
    }

    return ColorSelection(r: rgb[0], g: rgb[1], b: rgb[2]);
  }
}
