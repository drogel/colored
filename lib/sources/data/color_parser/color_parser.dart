import 'package:colored/sources/data/color_parser/color_parser_type.dart';
import 'package:colored/sources/data/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter/cupertino.dart';

class ColorParser implements ColorParserType {
  const ColorParser({
    @required FormatParser rgbParser,
    @required FormatParser hexParser,
    @required FormatParser hslParser,
    @required FormatParser hsvParser,
  })  : assert(rgbParser != null),
        assert(hexParser != null),
        assert(hslParser != null),
        assert(hsvParser != null),
        _rgbParser = rgbParser,
        _hexParser = hexParser,
        _hsvParser = hsvParser,
        _hslParser = hslParser;

  final FormatParser _rgbParser;
  final FormatParser _hexParser;
  final FormatParser _hslParser;
  final FormatParser _hsvParser;

  @override
  bool isStringOfFormat(String string, Format format) {
    switch (format) {
      case Format.hex:
        return _hexParser.hasMatch(string);
      case Format.rgb:
        return _rgbParser.hasMatch(string);
      case Format.hsl:
        return _hslParser.hasMatch(string);
      case Format.hsv:
        return _hsvParser.hasMatch(string);
      default:
        return false;
    }
  }

  @override
  ColorSelection parseToFormat(String string, Format format) {
    switch (format) {
      case Format.hex:
        return _hexParser.parse(string);
      case Format.rgb:
        return _rgbParser.parse(string);
      case Format.hsl:
        return _hslParser.parse(string);
      case Format.hsv:
        return _hsvParser.parse(string);
      default:
        return null;
    }
  }
}
