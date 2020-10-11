import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/hash.dart';

const NamedColor _kBlack = NamedColor(name: "Black", hex: "#000000");
const NamedColor _kWhite = NamedColor(name: "White", hex: "#FFFFFF");
final List<String> _kColors = [_kBlack.hex, _kWhite.hex];
const String _kName = "Black and white";

void main() {
  Palette palette;

  tearDown(() {
    palette = null;
  });

  group("Given a valid Palette", () {
    setUp(() => palette = Palette(name: _kName, hexCodes: _kColors));

    group("when constructed", () {
      test("then name can be accessed", () {
        expect(palette.name, _kName);
      });

      test("then namedColors can be accessed", () {
        expect(palette.hexCodes, _kColors);
      });
    });

    group("when toString is called", () {
      test("then a description of the palette is obtained", () {
        expect(
          palette.toString(),
          "Palette(name: $_kName, hexCodes: $_kColors)",
        );
      });
    });

    group("when hashCode is called", () {
      test("then the hashCode is built based on name and hex codes", () {
        const name = "test";

        final namedColor = Palette(name: name, hexCodes: _kColors);

        expect(namedColor.hashCode, hashObjects([name, _kColors]));
      });
    });
  });

  group("Given a non-valid palette", () {
    group("when constructed", () {
      test("then should throw if given null name", () {
        expect(
          () => Palette(name: null, hexCodes: _kColors),
          throwsAssertionError,
        );
      });

      test("then should throw if given null namedColors", () {
        expect(
          () => Palette(name: _kName, hexCodes: null),
          throwsAssertionError,
        );
      });
    });
  });

  group("Given two valid palettes", () {
    Palette otherPalette;

    setUp(() => palette = Palette(name: _kName, hexCodes: _kColors));

    tearDown(() {
      palette = null;
      otherPalette = null;
    });

    group("when compared", () {
      test("palettes are equal if they have the same namedColors and name", () {
        otherPalette = Palette(name: _kName, hexCodes: _kColors);
        expect(otherPalette == palette, true);
      });

      test("palettes are equal if they have the same namedColors", () {
        otherPalette = Palette(name: "Other", hexCodes: _kColors);
        expect(otherPalette == palette, true);
      });

      test("palettes are not equal if they don't have same namedColors", () {
        otherPalette = Palette(name: "Other", hexCodes: [_kWhite.hex]);
        expect(otherPalette == palette, false);
      });
    });
  });

  group("Given a palette map entry", () {
    test("then the fromMapEntry factory method can build a Palette object", () {
      final inputMap = {
        _kName: ["000000", "ffffff"]
      };
      final actual = Palette.fromMapEntry(inputMap.entries.first);
      expect(actual.name, _kName);
      expect(actual.hexCodes, ["#000000", "#FFFFFF"]);
    });
  });
}
