import 'package:colored/sources/data/color_helpers/parser/color_parser/parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';

class ColorParser implements Parser {
  const ColorParser({required Map<Format, FormatParser> formatParsers})
      : _formatParsers = formatParsers;

  final Map<Format, FormatParser> _formatParsers;

  @override
  bool isStringOfFormat(String string, Format format) {
    final selectedFormat = _formatParsers[format];
    if (selectedFormat == null) {
      throw ArgumentError("Unspecified $format in $runtimeType");
    }
    return selectedFormat.hasMatch(string);
  }

  @override
  ColorSelection parseFromFormat(String string, Format format) {
    final selectedFormat = _formatParsers[format];
    if (selectedFormat == null) {
      throw ArgumentError("Unspecified $format in $runtimeType");
    }
    return selectedFormat.parse(string);
  }
}
