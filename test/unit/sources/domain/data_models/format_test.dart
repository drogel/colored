import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a Format", () {
    group("when rawValue is called", () {
      test("the string description of the given value is retrieved", () {
        expect(Format.hex.rawValue, "Hex");
        expect(Format.rgb.rawValue, "RGB");
        expect(Format.hsl.rawValue, "HSL");
        expect(Format.hsv.rawValue, "HSV");
      });
    });

    group("when formatValue is called", () {
      test("then the format for the given description is retrieved", () {
        expect(formatValue("Hex"), Format.hex);
        expect(formatValue("RGB"), Format.rgb);
        expect(formatValue("HSL"), Format.hsl);
        expect(formatValue("HSV"), Format.hsv);
      });

      test("then retrieves null if the description doesn't map to value", () {
        expect(formatValue("Invalid Description"), isNull);
      });
    });
  });
}
