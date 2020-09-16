import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/hsv_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FormatParser hsvParser;

  setUp(() {
    hsvParser = HsvParser();
  });

  tearDown(() {
    hsvParser = null;
  });

  group("Given a HsvParser", () {
    group("when hasMatch is called", () {
      test("true is returned if input String is an hsv color code", () {
        expect(hsvParser.hasMatch("174°, 42%, 83%"), isTrue);
        expect(hsvParser.hasMatch("(174°, 42%, 83%)"), isTrue);
        expect(hsvParser.hasMatch("174°, 42%%, 83%"), isTrue);
        expect(hsvParser.hasMatch("174° 42%, 83%"), isTrue);
        expect(hsvParser.hasMatch("174° 42% 83%"), isTrue);
        expect(hsvParser.hasMatch("hsv(174° 42% 83%)"), isTrue);
        expect(hsvParser.hasMatch("174.1°, 42.3%, 83.6%"), isTrue);
        expect(hsvParser.hasMatch("174, 42%, 83%"), isTrue);
        expect(hsvParser.hasMatch("174°, 42, 83%"), isTrue);
        expect(hsvParser.hasMatch("174°, 42%, 83"), isTrue);
        expect(hsvParser.hasMatch("174°, 42, 83%"), isTrue);
        expect(hsvParser.hasMatch("174°, 42%, 83"), isTrue);
        expect(hsvParser.hasMatch("174, 42%, 83%"), isTrue);
        expect(hsvParser.hasMatch("360°, 0%, 100%"), isTrue);
        expect(hsvParser.hasMatch("724°, 0%, 100%"), isTrue);
        expect(hsvParser.hasMatch("360°, 120%, 100%"), isTrue);
        expect(hsvParser.hasMatch("360°, 100%, 200%"), isTrue);
        expect(hsvParser.hasMatch("360, 0, 100"), isTrue);
        expect(hsvParser.hasMatch("360.0, 0.0, 100.0"), isTrue);
        expect(hsvParser.hasMatch("174°, 42%, 83%, 100%"), isTrue);
        expect(hsvParser.hasMatch("174°, 42%, 83% this is a test"), isTrue);
      });

      test("false is returned if input String is null", () {
        expect(hsvParser.hasMatch(null), isFalse);
      });

      test("false is returned if input String is not an hsv color code", () {
        expect(hsvParser.hasMatch(""), isFalse);
        expect(hsvParser.hasMatch("2w"), isFalse);
        expect(hsvParser.hasMatch("hello"), isFalse);
        expect(hsvParser.hasMatch("hsl(174° 42% 83%)"), isFalse);
        expect(hsvParser.hasMatch("rgb(174 42 83)"), isFalse);
        expect(hsvParser.hasMatch("#232323"), isFalse);
      });
    });

    group("when parse is called", () {
      test("then the ColorSelection for the hex code is retrieved", () {
        expect(
          hsvParser.parse("0 100 50"),
          ColorSelection(r: 0.5, g: 0, b: 0),
        );
        expect(hsvParser.parse("0, 0, 100"), ColorSelection(r: 1, g: 1, b: 1));
        expect(
          hsvParser.parse("0°, 100%, 50%"),
          ColorSelection(r: 0.5, g: 0, b: 0),
        );
        expect(
          hsvParser.parse("300°, 100%, 50%"),
          ColorSelection(r: 0.5, g: 0, b: 0.5),
        );
        expect(
          hsvParser.parse("62°, 21%, 16%"),
          ColorSelection(r: 0.15888, g: 0.16, b: 0.1264),
        );
        expect(
          hsvParser.parse("142°, 21%, 16%"),
          ColorSelection(r: 0.1264, g: 0.16, b: 0.13872),
        );
        expect(
          hsvParser.parse("182°, 21%, 16%"),
          ColorSelection(r: 0.1264, g: 0.15888, b: 0.16),
        );
        expect(
          hsvParser.parse("242°, 21%, 16%"),
          ColorSelection(r: 0.12752, g: 0.1264, b: 0.16),
        );
        expect(
          hsvParser.parse("342°, 21%, 16%"),
          ColorSelection(r: 0.16, g: 0.1264, b: 0.13648),
        );
      });

      test("then an assertion error is thrown on null input string", () {
        expect(
          () => hsvParser.parse(null),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then an assertion error is thrown on empty input string", () {
        expect(
          () => hsvParser.parse(""),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });
}
