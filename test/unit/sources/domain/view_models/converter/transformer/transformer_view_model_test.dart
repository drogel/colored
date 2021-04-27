import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/data/color_helpers/transformer/color_transformer.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_injector.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

const _kDecimal8Bit = 255;
const _kInitialColor = Color(0x00000000);

void main() {
  late TransformerViewModel viewModel;
  late StreamController<TransformerState> stateController;

  setUp(() {
    stateController = StreamController<TransformerState>();
    viewModel = const TransformerInjector(initialColor: _kInitialColor)
        .injectViewModel(stateController);
  });

  tearDown(() {
    stateController.close();
  });

  group("Given a TransformerViewModel", () {
    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when initialState is get", () {
      test("then a TransformerState of the initial color is received", () {
        final actual = viewModel.initialState;
        expect(actual.selection, ColorSelection.fromColor(_kInitialColor));
      });
    });

    group("when stateStream is get", () {
      test("then stateController's stream is received", () {
        final actual = viewModel.stateStream;
        expect(actual, stateController.stream);
      });
    });

    group("when notifySelectionChanged is called", () {
      test("then a TransformerState is added to the stream", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen((state) {
          expect(state, isA<TransformerState>());
          expect(state.selection, selection);
        });
        viewModel.notifySelectionChanged(selection);
      });
    });

    group("when notifySelectionStarted is called", () {
      test("then a SelectionStarted is added to the stream", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen((state) {
          expect(state, isA<SelectionStarted>());
          expect(state.selection, selection);
        });
        viewModel.notifySelectionStarted(selection);
      });
    });

    group("when notifySelectionEnded is called", () {
      test("then a SelectionEnded is added to the stream", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen((state) {
          expect(state, isA<SelectionEnded>());
          expect(state.selection, selection);
        });
        viewModel.notifySelectionEnded(selection);
      });
    });

    group("when changeLightness is called with positive change", () {
      test("then a state with a higher lightness color is retrieved", () {
        final selection = ColorSelection(r: 0, g: 0.2, b: 0.4);
        final expected = TransformerState(
          ColorSelection(
            r: 10 / _kDecimal8Bit,
            g: 61 / _kDecimal8Bit,
            b: 112 / _kDecimal8Bit,
          ),
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(20, selection);
      });

      test("then a clamped state with a lighter color is retrieved", () {
        final selection = ColorSelection(r: 1, g: 0.2, b: 0.4);
        final expected = TransformerState(
          ColorSelection(
            r: 1,
            g: 61 / _kDecimal8Bit,
            b: 112 / _kDecimal8Bit,
          ),
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(20, selection);
      });
    });

    group("when changeLightness is called with negative change", () {
      test("then a state with a lower RGB color is retrieved", () {
        final selection = ColorSelection(r: 1, g: 0.2, b: 0.4);
        final expected = TransformerState(
          ColorSelection(
            r: 245 / _kDecimal8Bit,
            g: 41 / _kDecimal8Bit,
            b: 92 / _kDecimal8Bit,
          ),
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(-20, selection);
      });

      test("then a clamped state with a lower RGB color is retrieved", () {
        final selection = ColorSelection(r: 0, g: 0.2, b: 0.4);
        final expected = SelectionStarted(
          ColorSelection(
            r: 0,
            g: 41 / _kDecimal8Bit,
            b: 92 / _kDecimal8Bit,
          ),
        );
        stateController.stream.listen((state) => expect(state, expected));
        viewModel.changeLightness(-20, selection);
      });
    });

    group("when rotateColor is called with a positive 180 degrees change", () {
      test("then a state with an opposite color selection is retrieved", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen(
          (state) => expect(state.selection.r, 0),
        );
        viewModel.rotateColor(180, selection);
      });
    });

    group("when rotateColor is called with a negative 90 degrees change", () {
      test("then a state with rotated color selection is retrieved", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen(
          (state) => expect(state.selection.r.toStringAsFixed(4), "0.3333"),
        );
        viewModel.rotateColor(-90, selection);
      });
    });

    group("when rotateColor is called with a positive 360 degrees change", () {
      test("then a state with the same selection is retrieved", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen(
          (state) => expect(state.selection.r.toStringAsFixed(4), "1.0000"),
        );
        viewModel.rotateColor(360, selection);
      });
    });

    group("when rotateColor is called with a positive 540 degrees change", () {
      test("then a state with an opposite color selection is retrieved", () {
        final selection = ColorSelection(r: 1, g: 0, b: 0);
        stateController.stream.listen(
          (state) => expect(state.selection.r, 0),
        );
        viewModel.rotateColor(180, selection);
      });
    });
  });
}
