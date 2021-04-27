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
        expect(FormatValue.format("Hex"), Format.hex);
        expect(FormatValue.format("RGB"), Format.rgb);
        expect(FormatValue.format("HSL"), Format.hsl);
        expect(FormatValue.format("HSV"), Format.hsv);
      });

      test("then throws if the description doesn't map to value", () {
        expect(
          () => FormatValue.format("Invalid Description"),
          throwsArgumentError,
        );
      });
    });
  });
}
