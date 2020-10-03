import 'dart:async';

import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/picker/picker_state.dart';
import 'package:colored/sources/domain/view_models/picker/picker_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PickerViewModel viewModel;
  StreamController<PickerState> stateController;

  setUp(() {
    stateController = StreamController<PickerState>();
    viewModel = PickerViewModel(stateController: stateController);
  });

  tearDown(() {
    stateController.close();
    viewModel = null;
    stateController = null;
  });

  group("Given a PickerViewModel", () {
    group("when constructed", () {
      test("then an assertion error is thrown if stateController is null", () {
        expect(
          () => PickerViewModel(stateController: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when initialState is called", () {
      test("then a PickerState with PickerStyle.rgb is retrieved", () {
        final actual = viewModel.initialState;
        expect(actual.pickerStyle, PickerStyle.rgb);
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when updatePickerStyle is called for a valid index", () {
      test("then the PickerStyle of the given index is retrieved", () {
        viewModel.stateStream.listen((event) {
          expect(event.pickerStyle, PickerStyle.hsl);
        });
        viewModel.updatePickerStyle(1);
      });
    });
  });
}
