import 'dart:async';
import 'dart:ui';

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
  });
}
