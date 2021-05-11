import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a TransformerState", () {
    test("two TransformerStates are equal if their selection is equal", () {
      final firstState = TransformerState(ColorSelection(r: 0, g: 0, b: 0));
      final secondState = TransformerState(ColorSelection(r: 0, g: 0, b: 0));
      expect(firstState == secondState, isTrue);
    });

    test("two TransformerStates are not equal if selections are different", () {
      final firstState = TransformerState(ColorSelection(r: 1, g: 0, b: 0));
      final secondState = TransformerState(ColorSelection(r: 0, g: 0, b: 0));
      expect(firstState == secondState, isFalse);
    });

    test("then hashCode is obtained from the selection", () {
      final selection = ColorSelection(r: 1, g: 0, b: 0);
      final state = TransformerState(selection);
      expect(state.hashCode, selection.hashCode);
    });
  });

  group("Given a SelectionStarted", () {
    test("two SelectionStarted are equal if their selection is equal", () {
      final firstState = SelectionStarted(ColorSelection(r: 0, g: 0, b: 0));
      final secondState = SelectionStarted(ColorSelection(r: 0, g: 0, b: 0));
      expect(firstState == secondState, isTrue);
    });

    test("two SelectionStarted are not equal if selections are different", () {
      final firstState = SelectionStarted(ColorSelection(r: 1, g: 0, b: 0));
      final secondState = SelectionStarted(ColorSelection(r: 0, g: 0, b: 0));
      expect(firstState == secondState, isFalse);
    });
  });

  group("Given a SelectionEnded", () {
    test("two SelectionEnded are equal if their selection is equal", () {
      final firstState = SelectionEnded(ColorSelection(r: 0, g: 0, b: 0));
      final secondState = SelectionEnded(ColorSelection(r: 0, g: 0, b: 0));
      expect(firstState == secondState, isTrue);
    });

    test("two SelectionEnded are not equal if selections are different", () {
      final firstState = SelectionEnded(ColorSelection(r: 1, g: 0, b: 0));
      final secondState = SelectionEnded(ColorSelection(r: 0, g: 0, b: 0));
      expect(firstState == secondState, isFalse);
    });
  });
}
