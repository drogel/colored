import 'package:colored/sources/common/extensions/string_replace_non_alphanumeric.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

abstract class FormatParser {
  final RegExp doubleRegExp = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");

  ColorSelection parse(String string);

  bool hasMatch(String? input);

  List<double> getDoubleComponents(String string) {
    final cleanString = string.replacingAllNonAlphanumericBy(" ");
    return doubleRegExp
        .allMatches(cleanString)
        .map((match) => _parseDouble(match.group(0)))
        .toList();
  }

  double _parseDouble(String? string) {
    if (string == null) {
      throw ArgumentError("Null strings can't be parsed to doubles");
    }
    return double.parse(string);
  }
}
