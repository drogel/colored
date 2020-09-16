import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a DisplayedFormatsState", () {
    group("when constructed", () {
      test("then an error is thrown if formats is null", () {
        expect(
          () => DisplayedFormatsState(null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when checking for equality", () {
      test("then two states are equal if formats are equal", () {
        const firstState = DisplayedFormatsState([Format.hex, Format.hsl]);
        const secondState = DisplayedFormatsState([Format.hex, Format.hsl]);

        expect(firstState == secondState, isTrue);
      });

      test("then two states are not equal if formats differ", () {
        const firstState = DisplayedFormatsState([Format.hex, Format.hsl]);
        const secondState = DisplayedFormatsState([Format.hsv, Format.hsl]);

        expect(firstState == secondState, isFalse);
      });

      test("then two states are not equal if formats don't share order", () {
        const firstState = DisplayedFormatsState([Format.hex, Format.hsl]);
        const secondState = DisplayedFormatsState([Format.hsl, Format.hex]);

        expect(firstState == secondState, isFalse);
      });

      test("the hashCode is based on the formats hashcode", () {
        const formats = [Format.rgb, Format.hex];
        const state = DisplayedFormatsState(formats);

        expect(state.hashCode, formats.hashCode);
      });
    });

    group("when toString is called", () {
      test("a representation of the object with the formats is obtained", () {
        final formats = [Format.hex, Format.rgb];
        final state = DisplayedFormatsState(formats);

        expect(
          state.toString(),
          "DisplayedFormatsState([Format.hex, Format.rgb])",
        );
      });
    });
  });
}
