import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/color_helpers/converter/hsl_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Converter hsl;

  setUp(() {
    hsl = const HslConverter();
  });

  tearDown(() {
    hsl = null;
  });

  group("Given a HslConverter", () {
    group("when convert is called", () {
      test("then a map containing the converted HSL String is returned", () {
        expect(hsl.convert(66, 89, 72), {Format.hsl: "136°, 15%, 30%"});
        expect(hsl.convert(54, 35, 71), {Format.hsl: "272°, 34%, 21%"});
        expect(hsl.convert(0, 255, 0), {Format.hsl: "120°, 100%, 50%"});
        expect(hsl.convert(255, 255, 255), {Format.hsl: "0°, 0%, 100%"});
      });
    });
  });
}
