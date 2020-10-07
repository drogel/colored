import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a PaletteDetailState", () {
    group("when PaletteFound state is constructed", () {
      test("then an assertion error is thrown if namedColors is null", () {
        expect(
          () => PaletteFound(null),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });
}
