import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/color_helpers/converter/rgb_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Converter rgb;

  setUp(() {
    rgb = const RgbConverter();
  });

  tearDown(() {
    rgb = null;
  });

  group("Given a RgbConverter", () {
    group("when convert is called", () {
      test("then a map containing the converted RGB String is returned", () {
        expect(rgb.convert(59, 74, 53), {Format.rgb: "59, 74, 53"});
        expect(rgb.convert(161, 35, 142), {Format.rgb: "161, 35, 142"});
        expect(rgb.convert(0, 255, 0), {Format.rgb: "0, 255, 0"});
        expect(rgb.convert(255, 255, 255), {Format.rgb: "255, 255, 255"});
      });
    });
  });
}
