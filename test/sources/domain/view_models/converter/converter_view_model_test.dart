import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

const _kDecimal8Bit = 255;

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
        final selection = ColorSelection(
          first: 1,
          second: 0.2,
          third: 0.4,
        );
        final expected = ConverterState(
          color: const Color.fromRGBO(_kDecimal8Bit, 51, 102, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: selection,
          formatData: {
            Format.hex: "#FF3366",
            Format.rgb: "255, 51, 102",
            Format.hsl: "345°, 100%, 60%",
            Format.hsv: "345°, 80%, 100%",
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.notifySelection(selection);
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
        final selection = ColorSelection(
          first: 1,
          second: 0.2,
          third: 0.4,
        );
        final expected = ConverterState(
          color: const Color.fromRGBO(_kDecimal8Bit, 51, 102, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: selection,
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
        final selection = ColorSelection(
          first: 1,
          second: 0.2,
          third: 0.4,
        );
        final expected = ConverterState(
          color: const Color.fromRGBO(_kDecimal8Bit, 51, 102, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: selection,
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

    group("when changeLightness is called with positive change", () {
      test("then a state with a higher RGB color is retrieved", () {
        final selection = ColorSelection(
          first: 0,
          second: 0.2,
          third: 0.4,
        );
        final expected = ConverterState(
          color: const Color.fromRGBO(10, 61, 112, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: ColorSelection(
            first: 10 / _kDecimal8Bit,
            second: 61 / _kDecimal8Bit,
            third: 112 / _kDecimal8Bit,
          ),
          formatData: {
            Format.hex: "#0A3D70",
            Format.rgb: "10, 61, 112",
            Format.hsl: "210°, 84%, 24%",
            Format.hsv: "210°, 91%, 44%",
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(20, selection);
      });

      test("then a clamped state with a higher RGB color is retrieved", () {
        final selection = ColorSelection(
          first: 1,
          second: 0.2,
          third: 0.4,
        );
        final expected = ConverterState(
          color: const Color.fromRGBO(_kDecimal8Bit, 61, 112, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: ColorSelection(
            first: 1,
            second: 61 / _kDecimal8Bit,
            third: 112 / _kDecimal8Bit,
          ),
          formatData: {
            Format.hex: "#FF3D70",
            Format.rgb: "255, 61, 112",
            Format.hsl: "344°, 100%, 62%",
            Format.hsv: "344°, 76%, 100%",
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(20, selection);
      });
    });

    group("when changeLightness is called with negative change", () {
      test("then a state with a lower RGB color is retrieved", () {
        final selection = ColorSelection(
          first: 1,
          second: 0.2,
          third: 0.4,
        );
        final expected = ConverterState(
          color: const Color.fromRGBO(245, 41, 92, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: ColorSelection(
            first: 245 / _kDecimal8Bit,
            second: 41 / _kDecimal8Bit,
            third: 92 / _kDecimal8Bit,
          ),
          formatData: {
            Format.hex: "#F5295C",
            Format.rgb: "245, 41, 92",
            Format.hsl: "345°, 91%, 56%",
            Format.hsv: "345°, 83%, 96%",
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(-20, selection);
      });

      test("then a clamped state with a lower RGB color is retrieved", () {
        final selection = ColorSelection(
          first: 0,
          second: 0.2,
          third: 0.4,
        );
        final expected = Shrinking(
          color: const Color.fromRGBO(0, 41, 92, 1),
          converterStep: 1 / _kDecimal8Bit,
          selection: ColorSelection(
            first: 0,
            second: 41 / _kDecimal8Bit,
            third: 92 / _kDecimal8Bit,
          ),
          formatData: {
            Format.hex: "#00295C",
            Format.rgb: "0, 41, 92",
            Format.hsl: "213°, 100%, 18%",
            Format.hsv: "213°, 100%, 36%"
          },
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(-20, selection);
      });
    });

    group("when rotateColor is called with a positive 180 degrees change", () {
      test("then a state with an opposite color selection is retrieved", () {
        final selection = ColorSelection(
          first: 1,
          second: 0,
          third: 0,
        );
        stateController.stream.listen(
          (state) => expect(state.selection.first, 0),
        );
        viewModel.rotateColor(180, selection);
      });
    });

    group("when rotateColor is called with a negative 90 degrees change", () {
      test("then a state with rotated color selection is retrieved", () {
        final selection = ColorSelection(
          first: 1,
          second: 0,
          third: 0,
        );
        stateController.stream.listen(
          (state) => expect(state.selection.first.toStringAsFixed(4), "0.3333"),
        );
        viewModel.rotateColor(-90, selection);
      });
    });

    group("when rotateColor is called with a positive 360 degrees change", () {
      test("then a state with the same selection is retrieved", () {
        final selection = ColorSelection(
          first: 1,
          second: 0,
          third: 0,
        );
        stateController.stream.listen(
          (state) => expect(state.selection.first.toStringAsFixed(4), "1.0000"),
        );
        viewModel.rotateColor(360, selection);
      });
    });

    group("when rotateColor is called with a positive 540 degrees change", () {
      test("then a state with an opposite color selection is retrieved", () {
        final selection = ColorSelection(
          first: 1,
          second: 0,
          third: 0,
        );
        stateController.stream.listen(
          (state) => expect(state.selection.first, 0),
        );
        viewModel.rotateColor(180, selection);
      });
    });
  });
}
