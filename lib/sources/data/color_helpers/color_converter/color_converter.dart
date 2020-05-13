import 'package:colored/sources/data/color_helpers/color_converter/converter.dart';
import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/foundation.dart';

class ColorConverter implements Converter {
  const ColorConverter({
    @required Map<Format, FormatConverter> formatConverters,
  }) : _formatConverters = formatConverters;

  final Map<Format, FormatConverter> _formatConverters;

  @override
  String convertToFormat(int r, int g, int b, Format format) {
    try {
      return _formatConverters[format].convert(r, g, b);
    } on Exception catch (_) {
      throw UnimplementedError("Unspecified $format in $runtimeType");
    }
  }
}
