import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

class RgbParser extends FormatParser {
  final _rgbRegExp = RegExp(
      r"^(rgb)?\(?([01]?\d\d?|2[0-4]\d|25[0-5])(\W+)([01]?\d\d?|2[0-4]\d|25"
      r"[0-5])\W+(([01]?\d\d?|2[0-4]\d|25[0-5])\)?)$");

  @override
  bool hasMatch(String? input) {
    if (input == null) {
      return false;
    }
    return _rgbRegExp.hasMatch(input);
  }

  @override
  ColorSelection parse(String string) {
    assert(string.isNotEmpty, "String color format to parse cannot be empty");
    final rgbMatches = _rgbRegExp.firstMatch(string);
    if (rgbMatches == null) {
      throw ArgumentError("String can't be parsed to RGB");
    }
    final rgbMatched = rgbMatches.group(0);
    if (rgbMatched == null) {
      throw ArgumentError("String can't be parsed to RGB");
    }

    final rgbComponents = getDoubleComponents(rgbMatched);
    final selection = ColorSelection(
      r: rgbComponents[0] / decimal8Bit,
      g: rgbComponents[1] / decimal8Bit,
      b: rgbComponents[2] / decimal8Bit,
    );
    return selection;
  }
}
