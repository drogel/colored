import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/color_helpers/converter/hex_converter.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Converter? hexConverter;

  setUp(() {
    hexConverter = const HexConverter();
  });

  tearDown(() {
    hexConverter = null;
  });

  group("Given a HexConverter", () {
    group("when convert is called", () {
      test("then a map containing the converted hex String is returned", () {
        expect(hexConverter!.convert(255, 0, 255), {Format.hex: "#FF00FF"});
        expect(hexConverter!.convert(0, 0, 255), {Format.hex: "#0000FF"});
        expect(hexConverter!.convert(235, 64, 52), {Format.hex: "#EB4034"});
        expect(hexConverter!.convert(0, 0, 0), {Format.hex: "#000000"});
      });
    });
  });
}
