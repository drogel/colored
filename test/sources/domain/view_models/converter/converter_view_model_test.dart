import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/domain/data/color_format.dart';
import 'package:colored/sources/domain/data/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ConverterViewModel viewModel;
  StreamController<ConverterState> stateController;

  setUp(() {
    stateController = StreamController<ConverterState>();
    viewModel = ConverterViewModel(stateController: stateController);
  });

  tearDown(() {
    stateController.close();
    stateController = null;
    viewModel = null;
  });

  group("Given a ConverterViewModel,", () {
    group("when convertToColor is called with a selection", () {
      test("then a state with corresponding color is added to the stream", () {
        const selection = ColorSelection(
          firstComponent: 1,
          secondComponent: 0.2,
          thirdComponent: 0.4,
        );
        const expected = ConverterState(
          color: Color.fromRGBO(255, 51, 102, 1),
          rgbString: "255, 51, 102",
          hexString: "#FF3366",
          selection: selection,
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.convertToColor(selection);
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
          ColorFormat.hex,
        );
        expect(shouldHexStringFail, false);

        final shouldHexStringWithoutHashFail = viewModel.clipboardShouldFail(
          "FF00FF",
          ColorFormat.hex,
        );
        expect(shouldHexStringWithoutHashFail, false);
      });

      test("then false should return if string is not a valid hex color", () {
        final shouldNonHexStringFail = viewModel.clipboardShouldFail(
          "This is a sentence",
          ColorFormat.hex,
        );
        expect(shouldNonHexStringFail, true);

        final shouldRGBStringFail = viewModel.clipboardShouldFail(
          "(255, 255, 255)",
          ColorFormat.hex,
        );
        expect(shouldRGBStringFail, true);
      });
    });

    group("when clipboardShouldFail is called with RGB color format", () {
      test("then false should be returned if string is a valid RGB color", () {
        final shouldRGBStringFail = viewModel.clipboardShouldFail(
          "255, 255, 0",
          ColorFormat.rgb,
        );
        expect(shouldRGBStringFail, false);

        final shouldRGBStringParenthesisFail = viewModel.clipboardShouldFail(
          "(0, 0, 0)",
          ColorFormat.rgb,
        );
        expect(shouldRGBStringParenthesisFail, false);
      });

      test("then false should return if string is not a valid RGB color", () {
        final shouldNonRGBStringFail = viewModel.clipboardShouldFail(
          "This is a sentence",
          ColorFormat.rgb,
        );
        expect(shouldNonRGBStringFail, true);

        final shouldHexStringFail = viewModel.clipboardShouldFail(
          "#FFFFFF",
          ColorFormat.rgb,
        );
        expect(shouldHexStringFail, true);
      });
    });

    group("when convertStringToColor is called with RGB color format", () {
      test("then a state with parsed RGB color is added to the stream", () {
        const rgbString = "255, 51, 102";
        const selection = ColorSelection(
          firstComponent: 1,
          secondComponent: 0.2,
          thirdComponent: 0.4,
        );
        const expected = ConverterState(
          color: Color.fromRGBO(255, 51, 102, 1),
          rgbString: rgbString,
          hexString: "#FF3366",
          selection: selection,
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.convertStringToColor(rgbString, ColorFormat.rgb);
      });
    });

    group("when convertStringToColor is called with hex color format", () {
      test("then a state with parsed hex color is added to the stream", () {
        const hexString = "#FF3366";
        const selection = ColorSelection(
          firstComponent: 1,
          secondComponent: 0.2,
          thirdComponent: 0.4,
        );
        const expected = ConverterState(
          color: Color.fromRGBO(255, 51, 102, 1),
          rgbString: "255, 51, 102",
          hexString: hexString,
          selection: selection,
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.convertStringToColor(hexString, ColorFormat.hex);
      });
    });
  });
}
