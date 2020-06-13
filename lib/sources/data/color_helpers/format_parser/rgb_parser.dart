import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/common/extensions/string_replace_non_alphanumeric.dart';
import 'package:colored/sources/data/color_helpers/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

class RgbParser extends FormatParser {
  final _rgbRegExp = RegExp(
      r"^(rgb)?\(?([01]?\d\d?|2[0-4]\d|25[0-5])(\W+)([01]?\d\d?|2[0-4]\d|25"
      r"[0-5])\W+(([01]?\d\d?|2[0-4]\d|25[0-5])\)?)$");

  @override
  bool hasMatch(String input) => _rgbRegExp.hasMatch(input);

  @override
  ColorSelection parse(String string) {
    final rgbMatched = _rgbRegExp.firstMatch(string).group(0);
    final rgbWithoutSeparators = rgbMatched.replacingAllNonAlphanumericBy(" ");
    final rgbComponents = doubleRegExp
        .allMatches(rgbWithoutSeparators)
        .map((match) => double.parse(match.group(0)))
        .toList();

    final selection = ColorSelection(
      r: rgbComponents[0] / decimal8Bit,
      g: rgbComponents[1] / decimal8Bit,
      b: rgbComponents[2] / decimal8Bit,
    );
    return selection;
  }
}
