import 'package:colored/sources/data/color_helpers/converter/color_converter.dart';
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/color_helpers/converter/hex_converter.dart';
import 'package:colored/sources/data/color_helpers/converter/hsl_converter.dart';
import 'package:colored/sources/data/color_helpers/converter/hsv_converter.dart';
import 'package:colored/sources/data/color_helpers/converter/rgb_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Converter colorConverter;

  setUp(() {
    colorConverter = const ColorConverter(converters: [
      RgbConverter(),
      HexConverter(),
      HslConverter(),
      HsvConverter(),
    ]);
  });

  group("Given a ColorConverter with all format converters", () {
    group("when given an empty list of converters", () {
      test("then convert returns an empty map", () {
        const emptyColorConverter = ColorConverter(converters: []);

        expect(emptyColorConverter.convert(0, 0, 0), {});
      });
    });

    group("when convert is called", () {
      test("then a map containing the converted format String is returned", () {
        final expected = {
          Format.rgb: "59, 74, 53",
          Format.hex: "#3B4A35",
          Format.hsl: "103°, 17%, 25%",
          Format.hsv: "103°, 28%, 29%",
        };
        expect(colorConverter.convert(59, 74, 53), expected);
      });
    });
  });
}
