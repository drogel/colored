import 'dart:async';

import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/displayed_formats/displayed_formats_state.dart';
import 'package:colored/sources/domain/view_models/converter/displayed_formats/displayed_formats_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DisplayedFormatsViewModel? viewModel;
  StreamController<DisplayedFormatsState>? stateController;

  group("Given a DisplayedFormatsViewModel with all the possible formats", () {
    const allFormats = Format.values;

    setUp(() {
      stateController = StreamController<DisplayedFormatsState>();
      viewModel = DisplayedFormatsViewModel(stateController: stateController!);
    });

    tearDown(() {
      stateController!.close();
      viewModel = null;
      stateController = null;
    });

    group("when constructed", () {
      test("then an assertion error is thrown if stateController is null", () {
        expect(
          () => DisplayedFormatsViewModel(stateController: null),
          throwsAssertionError,
        );
      });
    });

    group("when initialState is called", () {
      test("then a DisplayedFormatsState with all formats is retrieved", () {
        final actual = viewModel!.initialState;
        expect(actual.formats, allFormats);
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController!.isClosed, false);
        viewModel!.dispose();
        expect(stateController!.isClosed, true);
      });
    });

    group("when updateDisplayedFormats is called", () {
      test("then a DisplayedFormatsState is emitted", () {
        viewModel!.stateStream.listen((event) {
          expect(event, isA<DisplayedFormatsState>());
        });
        viewModel!.updateDisplayedFormats(Format.hex, Format.hex);
      });

      test("then Format list is unchanged if selected equals previous", () {
        viewModel!.stateStream.listen((event) {
          expect(event.formats, viewModel!.initialState.formats);
        });
        viewModel!.updateDisplayedFormats(Format.hex, Format.hex);
      });

      test("then format list keeps its length if selected != previous", () {
        const selectedFormatIndex = 1;
        const previousFormatIndex = 0;
        final selected = allFormats[selectedFormatIndex];
        final previous = allFormats[previousFormatIndex];

        viewModel!.stateStream.listen((event) {
          expect(event.formats.length, allFormats.length);
        });

        viewModel!.updateDisplayedFormats(selected, previous);
      });

      test("then selected Format swaps place in the list with previous", () {
        const selectedFormatIndex = 1;
        const previousFormatIndex = 0;
        final selected = allFormats[selectedFormatIndex];
        final previous = allFormats[previousFormatIndex];

        viewModel!.stateStream.listen((event) {
          expect(event.formats.indexOf(selected), allFormats.indexOf(previous));
          expect(event.formats.indexOf(previous), allFormats.indexOf(selected));
        });

        viewModel!.updateDisplayedFormats(selected, previous);
      });
    });
  });
}
