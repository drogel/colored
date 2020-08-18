import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter_test/flutter_test.dart';

const NamedColor _kBlack = NamedColor(name: "Black", hex: "#000000");
const NamedColor _kWhite = NamedColor(name: "White", hex: "#FFFFFF");
const List<NamedColor> _kColors = [_kBlack, _kWhite];
const String _kName = "Black and white";

void main() {
  Palette palette;

  tearDown(() {
    palette = null;
  });

  group("Given a valid Palette", () {
    setUp(() => palette = const Palette(name: _kName, namedColors: _kColors));

    group("when constructed", () {
      test("then name can be accessed", () {
        expect(palette.name, _kName);
      });

      test("then namedColors can be accessed", () {
        expect(palette.namedColors, _kColors);
      });
    });

    group("when toString is called", () {
      test("then a description of the palette is obtained", () {
        expect(
          palette.toString(),
          "Palette(name: $_kName, namedColors: $_kColors)",
        );
      });
    });
  });

  group("Given a non-valid palette", () {
    group("when constructed", () {
      test("then should throw if given null name", () {
        expect(
          () => Palette(name: null, namedColors: _kColors),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then should throw if given null namedColors", () {
        expect(
          () => Palette(name: _kName, namedColors: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });

  group("Given two valid palettes", () {
    Palette otherPalette;

    setUp(() => palette = const Palette(name: _kName, namedColors: _kColors));

    tearDown(() {
      palette = null;
      otherPalette = null;
    });

    group("when compared", () {
      test("palettes are equal if they have the same namedColors and name", () {
        otherPalette = const Palette(name: _kName, namedColors: _kColors);
        expect(otherPalette == palette, true);
      });

      test("palettes are equal if they have the same namedColors", () {
        otherPalette = const Palette(name: "Other", namedColors: _kColors);
        expect(otherPalette == palette, true);
      });

      test("palettes are not equal if they don't have same namedColors", () {
        otherPalette = const Palette(name: "Other", namedColors: [_kWhite]);
        expect(otherPalette == palette, false);
      });
    });
  });
}
