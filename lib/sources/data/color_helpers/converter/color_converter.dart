import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/foundation.dart';

class ColorConverter implements Converter {
  const ColorConverter({
    required List<Converter> converters,
  })  : assert(converters != null),
        _converters = converters;

  final List<Converter> _converters;

  @override
  Map<Format, String> convert(int r, int g, int b) {
    if (_converters.isEmpty) {
      return {};
    }

    final formats = _converters.map((c) => c.convert(r, g, b)).toList();
    final formatData = formats.reduce((map, nextMap) => map..addAll(nextMap));
    return formatData;
  }
}
