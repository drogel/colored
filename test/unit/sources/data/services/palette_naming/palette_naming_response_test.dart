import 'package:colored/sources/data/services/palette_naming/palette_naming_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a PaletteNamingResponse", () {
    group("when constructed", () {
      test("then an assertion error is thrown if status is null", () {
        expect(
          () => PaletteNamingResponse(null),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });
}
