import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/hsl_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FormatParser hslParser;

  setUp(() {
    hslParser = HslParser();
  });

  tearDown(() {
    hslParser = null;
  });

  group("Given a HslParser", () {
    group("when hasMatch is called", () {
      test("true is returned if input String is an hsl color code", () {
        expect(hslParser.hasMatch("174°, 42%, 83%"), isTrue);
        expect(hslParser.hasMatch("(174°, 42%, 83%)"), isTrue);
        expect(hslParser.hasMatch("174°, 42%%, 83%"), isTrue);
        expect(hslParser.hasMatch("174° 42%, 83%"), isTrue);
        expect(hslParser.hasMatch("174° 42% 83%"), isTrue);
        expect(hslParser.hasMatch("hsl(174° 42% 83%)"), isTrue);
        expect(hslParser.hasMatch("174.1°, 42.3%, 83.6%"), isTrue);
        expect(hslParser.hasMatch("174, 42%, 83%"), isTrue);
        expect(hslParser.hasMatch("174°, 42, 83%"), isTrue);
        expect(hslParser.hasMatch("174°, 42%, 83"), isTrue);
        expect(hslParser.hasMatch("174°, 42, 83%"), isTrue);
        expect(hslParser.hasMatch("174°, 42%, 83"), isTrue);
        expect(hslParser.hasMatch("174, 42%, 83%"), isTrue);
        expect(hslParser.hasMatch("360°, 0%, 100%"), isTrue);
        expect(hslParser.hasMatch("724°, 0%, 100%"), isTrue);
        expect(hslParser.hasMatch("360°, 120%, 100%"), isTrue);
        expect(hslParser.hasMatch("360°, 100%, 200%"), isTrue);
        expect(hslParser.hasMatch("360, 0, 100"), isTrue);
        expect(hslParser.hasMatch("360.0, 0.0, 100.0"), isTrue);
        expect(hslParser.hasMatch("174°, 42%, 83%, 100%"), isTrue);
        expect(hslParser.hasMatch("174°, 42%, 83% this is a test"), isTrue);
      });

      test("false is returned if input String is null", () {
        expect(hslParser.hasMatch(null), isFalse);
      });

      test("false is returned if input String is not an hsl color code", () {
        expect(hslParser.hasMatch(""), isFalse);
        expect(hslParser.hasMatch("2w"), isFalse);
        expect(hslParser.hasMatch("hello"), isFalse);
        expect(hslParser.hasMatch("hsv(174° 42% 83%)"), isFalse);
        expect(hslParser.hasMatch("rgb(174 42 83)"), isFalse);
        expect(hslParser.hasMatch("#232323"), isFalse);
      });
    });

    group("when parse is called", () {
      test("then the ColorSelection for the hex code is retrieved", () {
        expect(hslParser.parse("0 100 50"), ColorSelection(r: 1, g: 0, b: 0));
        expect(hslParser.parse("0, 0, 100"), ColorSelection(r: 1, g: 1, b: 1));
        expect(
          hslParser.parse("0°, 100%, 50%"),
          ColorSelection(r: 1, g: 0, b: 0),
        );
        expect(
          hslParser.parse("300°, 100%, 50%"),
          ColorSelection(r: 1, g: 0, b: 1),
        );
      });

      test("then an assertion error is thrown on null input string", () {
        expect(
          () => hslParser.parse(null),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then an assertion error is thrown on empty input string", () {
        expect(
          () => hslParser.parse(""),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });
}
