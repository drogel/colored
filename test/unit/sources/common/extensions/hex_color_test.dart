import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a HexColor extension", () {
    group("when fromHex is called", () {
      test("the Color object from the hex code is built", () {
        const hexCode = "000000";

        final actualColor = HexColor.fromHex(hexCode);

        expect(actualColor.red, 0);
        expect(actualColor.blue, 0);
        expect(actualColor.green, 0);
      });
    });

    test("the Color object from the hex code is built with leading #", () {
      const hexCode = "#000000";

      final actualColor = HexColor.fromHex(hexCode);

      expect(actualColor.red, 0);
      expect(actualColor.blue, 0);
      expect(actualColor.green, 0);
    });

    group("when toHex is called", () {
      test("returns the expected hex code with leading #", () {
        const hexCode = "000000";

        final actualColor = HexColor.fromHex(hexCode);

        expect(actualColor.toHex(), "#$hexCode");
      });

      test("returns the expected hex code without leading #", () {
        const hexCode = "000000";

        final actualColor = HexColor.fromHex(hexCode);

        expect(actualColor.toHex(leadingHashSign: false), hexCode);
      });
    });
  });
}
