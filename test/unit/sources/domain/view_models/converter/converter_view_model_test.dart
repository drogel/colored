import 'dart:async';

import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ConverterViewModel viewModel;
  StreamController<ConverterState> stateController;

  setUp(() {
    stateController = StreamController<ConverterState>();
    viewModel = const ConverterInjector().injectViewModel(stateController);
  });

  tearDown(() {
    stateController.close();
    stateController = null;
    viewModel = null;
  });

  group("Given a ConverterViewModel,", () {
    group("when convertToColor is called with a selection", () {
      test("then a state with corresponding color is added to the stream", () {
        final selection = ColorSelection(r: 1, g: 0.2, b: 0.4);
        const expected = ConverterState(
          formatData: {
            Format.hex: "#FF3366",
            Format.rgb: "255, 51, 102",
            Format.hsl: "345°, 100%, 60%",
            Format.hsv: "345°, 80%, 100%",
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.notifySelectionChanged(selection);
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when stateStream is get", () {
      test("then stateController's stream is received", () {
        final actual = viewModel.stateStream;
        expect(actual, stateController.stream);
      });
    });

    group("when clipboardShouldFail is called with hex color format", () {
      test("then false should be returned if string is a valid hex color", () {
        final shouldHexStringFail = viewModel.clipboardShouldFail(
          "#FF00FF",
          Format.hex,
        );
        expect(shouldHexStringFail, false);

        final shouldHexStringWithoutHashFail = viewModel.clipboardShouldFail(
          "FF00FF",
          Format.hex,
        );
        expect(shouldHexStringWithoutHashFail, false);
      });

      test("then false should return if string is not a valid hex color", () {
        final shouldNonHexStringFail = viewModel.clipboardShouldFail(
          "This is a sentence",
          Format.hex,
        );
        expect(shouldNonHexStringFail, true);

        final shouldRGBStringFail = viewModel.clipboardShouldFail(
          "(_kDecimal8Bit, _kDecimal8Bit, _kDecimal8Bit)",
          Format.hex,
        );
        expect(shouldRGBStringFail, true);
      });
    });

    group("when clipboardShouldFail is called with RGB color format", () {
      test("then false should be returned if string is a valid RGB color", () {
        final shouldRGBStringFail = viewModel.clipboardShouldFail(
          "255, 255, 0",
          Format.rgb,
        );
        expect(shouldRGBStringFail, false);

        final shouldRGBStringParenthesisFail = viewModel.clipboardShouldFail(
          "(0, 0, 0)",
          Format.rgb,
        );
        expect(shouldRGBStringParenthesisFail, false);
      });

      test("then false should return if string is not a valid RGB color", () {
        final shouldNonRGBStringFail = viewModel.clipboardShouldFail(
          "This is a sentence",
          Format.rgb,
        );
        expect(shouldNonRGBStringFail, true);

        final shouldHexStringFail = viewModel.clipboardShouldFail(
          "#FFFFFF",
          Format.rgb,
        );
        expect(shouldHexStringFail, true);
      });
    });

    group("when convertStringToColor is called with RGB color format", () {
      test("then a state with parsed RGB color is added to the stream", () {
        const rgbString = "255, 51, 102";
        const expected = ConverterState(
          formatData: {
            Format.hex: "#FF3366",
            Format.rgb: rgbString,
            Format.hsl: "345°, 100%, 60%",
            Format.hsv: "345°, 80%, 100%",
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.convertStringToColor(rgbString, Format.rgb);
      });
    });

    group("when convertStringToColor is called with hex color format", () {
      test("then a state with parsed hex color is added to the stream", () {
        const hexString = "#FF3366";
        const expected = ConverterState(
          formatData: {
            Format.hex: hexString,
            Format.rgb: "255, 51, 102",
            Format.hsl: "345°, 100%, 60%",
            Format.hsv: "345°, 80%, 100%"
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.convertStringToColor(hexString, Format.hex);
      });
    });
  });
}
