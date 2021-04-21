import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/rgb_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FormatParser? rgbParser;

  setUp(() {
    rgbParser = RgbParser();
  });

  tearDown(() {
    rgbParser = null;
  });

  group("Given a RgbParser", () {
    group("when hasMatch is called", () {
      test("true is returned if input String is an rgb color code", () {
        expect(rgbParser!.hasMatch("174, 42, 83"), isTrue);
        expect(rgbParser!.hasMatch("(174, 42, 83)"), isTrue);
        expect(rgbParser!.hasMatch("174 42, 83"), isTrue);
        expect(rgbParser!.hasMatch("174 42 83"), isTrue);
        expect(rgbParser!.hasMatch("rgb(174 42 83)"), isTrue);
        expect(rgbParser!.hasMatch("rgb(174, 42, 83)"), isTrue);
      });

      test("false is returned if input String is null", () {
        expect(rgbParser!.hasMatch(null), isFalse);
      });

      test("false is returned if input String is not an rgb color code", () {
        expect(rgbParser!.hasMatch(""), isFalse);
        expect(rgbParser!.hasMatch("2w"), isFalse);
        expect(rgbParser!.hasMatch("hello"), isFalse);
        expect(rgbParser!.hasMatch("hsl(174° 42% 83%)"), isFalse);
        expect(rgbParser!.hasMatch("hsv(174 42 83)"), isFalse);
        expect(rgbParser!.hasMatch("#232323"), isFalse);
        expect(rgbParser!.hasMatch("174.1, 42.3, 83.6"), isFalse);
        expect(rgbParser!.hasMatch("360, 0, 100"), isFalse);
        expect(rgbParser!.hasMatch("360, 300, 256"), isFalse);
        expect(rgbParser!.hasMatch("360.0, 0.0, 100.0"), isFalse);
        expect(rgbParser!.hasMatch("174, 42, 83, 100"), isFalse);
        expect(rgbParser!.hasMatch("174, 42, 83 this is a test"), isFalse);
        expect(rgbParser!.hasMatch("174°, 42%, 83%"), isFalse);
      });
    });

    group("when parse is called", () {
      test("then the ColorSelection for the hex code is retrieved", () {
        expect(
          rgbParser!.parse("0 255 255"),
          ColorSelection(r: 0, g: 1, b: 1),
        );
        expect(rgbParser!.parse("0, 0, 255"), ColorSelection(r: 0, g: 0, b: 1));
        expect(
          rgbParser!.parse("0, 255, 128"),
          ColorSelection(r: 0, g: 1, b: 0.5019607843137255),
        );
        expect(
          rgbParser!.parse("128, 0, 128"),
          ColorSelection(r: 0.5019607843137255, g: 0, b: 0.5019607843137255),
        );
      });

      test("then an assertion error is thrown on null input string", () {
        expect(
          () => rgbParser!.parse(null),
          throwsAssertionError,
        );
      });

      test("then an assertion error is thrown on empty input string", () {
        expect(
          () => rgbParser!.parse(""),
          throwsAssertionError,
        );
      });
    });
  });
}
