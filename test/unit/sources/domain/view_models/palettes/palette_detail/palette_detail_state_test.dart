import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a PaletteDetailState", () {
    group("when a Pending state is constructed", () {
      test("then the paletteName from its superclass is initialized", () {
        const testPaletteName = "test";
        const testState = Pending(testPaletteName, []);
        expect(testState.paletteName, testPaletteName);
      });
    });
  });
}
