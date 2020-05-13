import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';
import 'package:colored/sources/common/factors.dart';

class HexConverter implements FormatConverter {
  const HexConverter();

  @override
  String convert(int r, int g, int b) {
    final hexRed = _convertDecimalToHex(r);
    final hexGreen = _convertDecimalToHex(g);
    final hexBlue = _convertDecimalToHex(b);
    return "#$hexRed$hexGreen$hexBlue";
  }

  String _convertDecimalToHex(int decimal) =>
      decimal.toRadixString(hexMod).padLeft(2, "0").toUpperCase();
}