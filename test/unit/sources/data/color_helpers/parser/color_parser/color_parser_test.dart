import 'package:colored/sources/data/color_helpers/parser/color_parser/color_parser.dart';
import 'package:colored/sources/data/color_helpers/parser/color_parser/parser.dart';
import 'package:colored/sources/data/color_helpers/parser/format_parser/rgb_parser.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Parser colorParser;

  setUp(() {
    colorParser = const ColorParser(formatParsers: {});
  });

  group("Given a ColorParser", () {
    group("when isStringOfFormat is called", () {
      test("an UnimplementedError is thrown if formatParsers is empty", () {
        expect(
          () => colorParser.isStringOfFormat("test", Format.hex),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test("an error is thrown if the given format is not found", () {
        final rgbOnlyParser = ColorParser(formatParsers: {
          Format.rgb: RgbParser(),
        });

        expect(
          () => rgbOnlyParser.isStringOfFormat("test", Format.hex),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });

    group("when parseFromFormat is called", () {
      test("an UnimplementedError is thrown if formatParsers is empty", () {
        expect(
          () => colorParser.parseFromFormat("test", Format.hex),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test("an error is thrown if the given format is not found", () {
        final rgbOnlyParser = ColorParser(formatParsers: {
          Format.rgb: RgbParser(),
        });

        expect(
          () => rgbOnlyParser.parseFromFormat("test", Format.hex),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });
  });
}
