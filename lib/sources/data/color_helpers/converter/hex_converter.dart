import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/domain/data_models/format.dart';

class HexConverter implements Converter {
  const HexConverter();

  @override
  Map<Format, String> convert(int r, int g, int b) {
    final hexRed = _convertDecimalToHex(r);
    final hexGreen = _convertDecimalToHex(g);
    final hexBlue = _convertDecimalToHex(b);
    return {Format.hex: "#$hexRed$hexGreen$hexBlue"};
  }

  String _convertDecimalToHex(int decimal) =>
      decimal.toRadixString(hexMod).padLeft(2, "0").toUpperCase();
}