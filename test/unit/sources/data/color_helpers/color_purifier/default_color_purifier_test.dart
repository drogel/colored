import 'dart:ui';

import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ColorPurifier purifier;

  setUp(() {
    purifier = const DefaultColorPurifier();
  });

  tearDown(() {
    purifier = null;
  });

  void runPurifyTest({@required Color pureColor, @required Color inputColor}) =>
      expect(purifier.purify(inputColor), pureColor);

  void runGetHueTest({
    @required double expectedHue,
    @required Color inputColor,
  }) =>
      expect(purifier.getHue(inputColor), expectedHue);

  void runGetPureColorFromHueTest({
    @required Color expectedColor,
    @required double inputHue,
  }) =>
      expect(purifier.getPureColorFromHue(inputHue), expectedColor);

  group("Given a DefaultColorPurifier", () {
    group("when purify is called", () {
      test("the pure hue version of the given color is returned", () {
        runPurifyTest(
          pureColor: const Color.fromRGBO(255, 0, 0, 1),
          inputColor: const Color.fromRGBO(128, 62, 62, 1),
        );
        runPurifyTest(
          pureColor: const Color.fromRGBO(0, 255, 0, 1),
          inputColor: const Color.fromRGBO(45, 156, 45, 1),
        );
        runPurifyTest(
          pureColor: const Color.fromRGBO(0, 0, 255, 1),
          inputColor: const Color.fromRGBO(157, 157, 201, 1),
        );
        runPurifyTest(
          pureColor: const Color.fromRGBO(0, 247, 255, 1),
          inputColor: const Color.fromRGBO(34, 65, 66, 1),
        );
      });
    });

    group("when getHue is called", () {
      test("then the hue of the color is returned", () {
        runGetHueTest(
          expectedHue: 0,
          inputColor: const Color.fromRGBO(255, 0, 0, 1),
        );
        runGetHueTest(
          expectedHue: 120,
          inputColor: const Color.fromRGBO(0, 255, 0, 1),
        );
        runGetHueTest(
          expectedHue: 240,
          inputColor: const Color.fromRGBO(0, 0, 255, 1),
        );
        runGetHueTest(
          expectedHue: 300,
          inputColor: const Color.fromRGBO(89, 46, 89, 1),
        );
      });
    });

    group("when getPureColorFromHue is called", () {
      test("then the pure Color object with the input hue is returned", () {
        runGetPureColorFromHueTest(
          expectedColor: const Color.fromRGBO(255, 0, 0, 1),
          inputHue: 0,
        );
        runGetPureColorFromHueTest(
          expectedColor: const Color.fromRGBO(0, 255, 0, 1),
          inputHue: 120,
        );
        runGetPureColorFromHueTest(
          expectedColor: const Color.fromRGBO(0, 0, 255, 1),
          inputHue: 240,
        );
        runGetPureColorFromHueTest(
          expectedColor: const Color.fromRGBO(255, 0, 255, 1),
          inputHue: 300,
        );
      });
    });
  });
}
