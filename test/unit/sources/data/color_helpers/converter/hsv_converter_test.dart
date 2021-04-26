import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/color_helpers/converter/hsv_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Converter hsv;

  setUp(() {
    hsv = const HsvConverter();
  });

  group("Given a HsvConverter", () {
    group("when convert is called", () {
      test("then a map containing the converted HSV String is returned", () {
        expect(hsv.convert(59, 74, 53), {Format.hsv: "103°, 28%, 29%"});
        expect(hsv.convert(161, 35, 142), {Format.hsv: "309°, 78%, 63%"});
        expect(hsv.convert(0, 255, 0), {Format.hsv: "120°, 100%, 100%"});
        expect(hsv.convert(255, 255, 255), {Format.hsv: "0°, 0%, 100%"});
      });
    });
  });
}
