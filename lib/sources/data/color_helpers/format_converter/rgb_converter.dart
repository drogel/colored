import 'package:colored/sources/data/color_helpers/format_converter/format_converter.dart';

class RgbConverter implements FormatConverter {
  const RgbConverter();

  @override
  String convert(int r, int g, int b) => "$r, $g, $b";
}
