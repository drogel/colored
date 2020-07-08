import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';

class RgbConverter implements Converter {
  const RgbConverter();

  @override
  Map<Format, String> convert(int r, int g, int b) =>
      {Format.rgb: "$r, $g, $b"};
}
