import 'package:colored/sources/data/color_helpers/parser/format_parser/format_parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/hex_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FormatParser hexParser;

  setUp(() {
    hexParser = HexParser();
  });

  tearDown(() {
    hexParser = null;
  });

  group("Given a HexParser", () {
    group("when hasMatch is called", () {
      test("true is returned if input String is a hex color code", () {
        expect(hexParser.hasMatch("#FF00AB"), isTrue);
        expect(hexParser.hasMatch("#0a0a0a"), isTrue);
        expect(hexParser.hasMatch("#fff"), isTrue);
        expect(hexParser.hasMatch("fff"), isTrue);
        expect(hexParser.hasMatch("ff00FF"), isTrue);
        expect(hexParser.hasMatch("123456"), isTrue);
      });

      test("false is returned if input String is null", () {
        expect(hexParser.hasMatch(null), isFalse);
      });

      test("false is returned if input String is not a hex color code", () {
        expect(hexParser.hasMatch(""), isFalse);
        expect(hexParser.hasMatch("2w"), isFalse);
        expect(hexParser.hasMatch("hello"), isFalse);
        expect(hexParser.hasMatch("#ffwcff"), isFalse);
        expect(hexParser.hasMatch("#232323%!"), isFalse);
      });

      test("false is returned if input String is a hex code with opacity", () {
        expect(hexParser.hasMatch("#232323FF"), isFalse);
        expect(hexParser.hasMatch("#FFFFFF00"), isFalse);
      });
    });

    group("when parse is called", () {
      test("then the ColorSelection for the hex code is retrieved", () {
        expect(hexParser.parse("#FF0000"), ColorSelection(r: 1, g: 0, b: 0));
        expect(hexParser.parse("#FFFFFF"), ColorSelection(r: 1, g: 1, b: 1));
        expect(hexParser.parse("FF0000"), ColorSelection(r: 1, g: 0, b: 0));
        expect(hexParser.parse("FF00FF"), ColorSelection(r: 1, g: 0, b: 1));
      });

      test("then an assertion error is thrown on null input string", () {
        expect(
          () => hexParser.parse(null),
          throwsAssertionError,
        );
      });

      test("then an assertion error is thrown on empty input string", () {
        expect(
          () => hexParser.parse(""),
          throwsAssertionError,
        );
      });
    });
  });
}
