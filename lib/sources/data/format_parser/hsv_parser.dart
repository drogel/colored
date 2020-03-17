import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/common/extensions/string_replace_non_alphanumeric.dart';

class HsvParser extends FormatParser {
  final _hsvRegExp = RegExp(r"^(hsl)?\(?\s*(\d+)\s*(°)?(\W+)"
      r"\s*(\d*(?:\.\d+)?(%)?)\s*(\W+)\s*(\d*(?:\.\d+)?(%)?)\)?");

  @override
  bool hasMatch(String input) => _hsvRegExp.hasMatch(input);

  @override
  ColorSelection parse(String string) {
    final hsvMatched = _hsvRegExp.firstMatch(string).group(0);
    final hsvWithoutSeparators = hsvMatched.replacingAllNonAlphanumericBy(" ");
    final hsvComponents = doubleRegExp
        .allMatches(hsvWithoutSeparators)
        .map((match) => double.parse(match.group(0)))
        .toList();
    var rgb = <double>[0, 0, 0];

    final hue = hsvComponents[0] / degreesInTurn % 1;
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

    return ColorSelection(first: rgb[0], second: rgb[1], third: rgb[2]);
  }
}
