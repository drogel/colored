import 'dart:async';

import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as color_constants;
import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/color_helpers/parser/color_parser/parser.dart';
import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockOrientationService extends Mock implements DeviceOrientationService {}

class MockParser extends Mock implements Parser {}

class MockConverter extends Mock implements Converter {}

abstract class OnSelectionDoneCallbackProvider {
  void onDone(ColorSelection selection);
}

class MockOnSelectionDoneCallbackProvider extends Mock
    implements OnSelectionDoneCallbackProvider {}

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
    group("when constructed", () {
      test("then an assertion error is thrown if stateController is null", () {
        expect(
          () => ConverterViewModel(
            stateController: null,
            deviceOrientationService: MockOrientationService(),
            colorConverter: MockConverter(),
            colorParser: MockParser(),
          ),
          throwsAssertionError,
        );
      });

      test("then an assertion error is thrown if colorParser is null", () {
        expect(
          () => ConverterViewModel(
            stateController: stateController,
            deviceOrientationService: MockOrientationService(),
            colorConverter: MockConverter(),
            colorParser: null,
          ),
          throwsAssertionError,
        );
      });

      test("then an assertion error is thrown if colorConverter is null", () {
        expect(
          () => ConverterViewModel(
            stateController: stateController,
            deviceOrientationService: MockOrientationService(),
            colorConverter: null,
            colorParser: MockParser(),
          ),
          throwsAssertionError,
        );
      });

      test("then an error is thrown if deviceOrientationService is null", () {
        expect(
          () => ConverterViewModel(
            stateController: stateController,
            deviceOrientationService: null,
            colorConverter: MockConverter(),
            colorParser: MockParser(),
          ),
          throwsAssertionError,
        );
      });
    });

    group("when initialstate is called", () {
      test("then an initial state with the primaryDark color is returned", () {
        final actual = viewModel.initialState;

        const expectedColor = color_constants.primaryDark;

        expect(
          actual.formatData[Format.rgb],
          "${expectedColor.red}, ${expectedColor.green}, ${expectedColor.blue}",
        );
      });
    });

    group("when init is called", () {
      test("then the orientation service is asked to set all orientations", () {
        final orientationService = MockOrientationService();

        final mockedViewModel = ConverterViewModel(
          stateController: stateController,
          colorParser: MockParser(),
          colorConverter: MockConverter(),
          deviceOrientationService: orientationService,
        );

        mockedViewModel.init();
        verify(orientationService.setAllOrientations());
        verifyNoMoreInteractions(orientationService);
      });
    });

    group("when notifySelectionChanged is called with a selection", () {
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

    group("when convertStringToColor is called", () {
      test("then onDone is called", () {
        final callbackProvider = MockOnSelectionDoneCallbackProvider();

        viewModel.convertStringToColor(
          "#000000",
          Format.hex,
          onDone: callbackProvider.onDone,
        );

        verify(callbackProvider.onDone(any));
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
