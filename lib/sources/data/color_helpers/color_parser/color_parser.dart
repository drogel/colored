import 'package:colored/sources/data/color_helpers/color_parser/color_parser_type.dart';
import 'package:colored/sources/data/color_helpers/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/cupertino.dart';

class ColorParser implements ColorParserType {
  const ColorParser({@required Map<Format, FormatParser> formatParsers})
      : assert(formatParsers != null),
        _formatParsers = formatParsers;

  final Map<Format, FormatParser> _formatParsers;

  @override
  bool isStringOfFormat(String string, Format format) =>
      _formatParsers[format].hasMatch(string);

  @override
  ColorSelection parseToFormat(String string, Format format) =>
      _formatParsers[format].parse(string);
}
