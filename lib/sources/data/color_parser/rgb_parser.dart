import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/common/extensions/string_replace_non_alphanumeric.dart';
import 'package:colored/sources/data/color_parser/color_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

class RgbParser extends ColorParser {
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
      first: rgbComponents[0] / decimal8Bit,
      second: rgbComponents[1] / decimal8Bit,
      third: rgbComponents[2] / decimal8Bit,
    );
    return selection;
  }
}
