import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/hash.dart';

const String _kName = "Black";
const String _kHexCode = "#000000";

void main() {
  NamedColor? namedColor;

  tearDown(() {
    namedColor = null;
  });

  group("Given a valid NamedColor", () {
    setUp(() => namedColor = const NamedColor(name: _kName, hex: _kHexCode));

    group("when constructed", () {
      test("then name can be accessed", () {
        expect(namedColor!.name, _kName);
      });

      test("then hex can be accessed", () {
        expect(namedColor!.hex, _kHexCode);
      });
    });

    group("when toString is called", () {
      test("then a description of the named color is obtained", () {
        expect(
          namedColor.toString(),
          "NamedColor(name: $_kName, hex: $_kHexCode)",
        );
      });
    });

    group("when hashCode is called", () {
      test("then the hashCode is built based on name and hex code", () {
        const hex = "000000";
        const name = "test";

        const namedColor = NamedColor(name: name, hex: hex);

        expect(namedColor.hashCode, hashObjects([name, hex]));
      });
    });

    group("when fromMapEntry is called", () {
      test("then a NamedColor with the data from entry is instantiated", () {
        const mapEntry = MapEntry<String, dynamic>("ffffff", "White");
        final actual = NamedColor.fromMapEntry(mapEntry);
        expect(actual.name, "White");
        expect(actual.hex, "#FFFFFF");
      });
    });
  });

  group("Given a non-valid NamedColor", () {
    group("when constructed", () {
      test("then should throw if given null name", () {
        expect(
          () => NamedColor(name: null, hex: _kHexCode),
          throwsAssertionError,
        );
      });

      test("then should throw if given null hex code", () {
        expect(
          () => NamedColor(name: _kName, hex: null),
          throwsAssertionError,
        );
      });
    });
  });

  group("Given two valid palettes", () {
    NamedColor? otherNamedColor;

    setUp(() => namedColor = const NamedColor(name: _kName, hex: _kHexCode));

    tearDown(() {
      namedColor = null;
      otherNamedColor = null;
    });

    group("when compared", () {
      test("namedColors are equal if they have same hex and name", () {
        otherNamedColor = const NamedColor(name: _kName, hex: _kHexCode);
        expect(otherNamedColor == namedColor, true);
      });

      test("namedColors are not equal if they don't have same name", () {
        otherNamedColor = const NamedColor(name: "Other", hex: _kHexCode);
        expect(otherNamedColor == namedColor, false);
      });

      test("namedColors are not equal if they don't have same hex code", () {
        otherNamedColor = const NamedColor(name: _kName, hex: "Other");
        expect(otherNamedColor == namedColor, false);
      });
    });
  });
}
