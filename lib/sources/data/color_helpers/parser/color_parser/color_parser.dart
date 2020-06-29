import 'package:colored/sources/data/color_helpers/parser/color_parser/parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/material.dart';

class ColorParser implements Parser {
  const ColorParser({@required Map<Format, FormatParser> formatParsers})
      : assert(formatParsers != null),
        _formatParsers = formatParsers;

  final Map<Format, FormatParser> _formatParsers;

  @override
  bool isStringOfFormat(String string, Format format) {
    try {
      return _formatParsers[format].hasMatch(string);
    } on Exception catch (_) {
      throw UnimplementedError("Unspecified $format in $runtimeType");
    }
  }

  @override
  ColorSelection parseFromFormat(String string, Format format) {
    try {
      return _formatParsers[format].parse(string);
    } on Exception catch (_) {
      throw UnimplementedError("Unspecified $format in $runtimeType");
    }
  }
}
