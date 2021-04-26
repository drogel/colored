import 'dart:ui';

import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a ColorSelection", () {
    group("when fromHSV is called", () {
      test("then a ColorSelection is built from the HSV values", () {
        final black = ColorSelection.fromHSV(h: 0, s: 0, v: 0);
        final red = ColorSelection.fromHSV(h: 0, s: 1, v: 1);
        final white = ColorSelection.fromHSV(h: 0, s: 0, v: 1);

        expect(black, ColorSelection(r: 0, g: 0, b: 0));
        expect(red, ColorSelection(r: 255, g: 0, b: 0));
        expect(white, ColorSelection(r: 255, g: 255, b: 255));
      });
    });

    group("when fromHSL is called", () {
      test("then a ColorSelection is built from the HSL values", () {
        final black = ColorSelection.fromHSL(h: 0, s: 0, l: 0);
        final red = ColorSelection.fromHSL(h: 0, s: 1, l: 0.5);
        final white = ColorSelection.fromHSL(h: 0, s: 0, l: 1);

        expect(black, ColorSelection(r: 0, g: 0, b: 0));
        expect(red, ColorSelection(r: 255, g: 0, b: 0));
        expect(white, ColorSelection(r: 255, g: 255, b: 255));
      });
    });

    group("when toColor is called", () {
      test("then a Color object for the given ColorSelection is returned", () {
        final black = ColorSelection(r: 0, g: 0, b: 0);
        final red = ColorSelection(r: 1, g: 0, b: 0);
        final white = ColorSelection(r: 1, g: 1, b: 1);

        expect(black.toColor(), const Color.fromRGBO(0, 0, 0, 1));
        expect(red.toColor(), const Color.fromRGBO(255, 0, 0, 1));
        expect(white.toColor(), const Color.fromRGBO(255, 255, 255, 1));
      });
    });

    group("when toString is called", () {
      test("a representation of the color object with its values is given", () {
        final colorSelection = ColorSelection(r: 0, g: 1, b: 0);

        expect(
          colorSelection.toString(),
          "ColorSelection(r: 0.0, g: 1.0, b: 0.0)",
        );
      });
    });
  });
}
