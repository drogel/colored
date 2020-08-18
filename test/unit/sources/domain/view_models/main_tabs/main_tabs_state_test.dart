import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a MainTabsState", () {
    group("when constructed", () {
      test("then passing a null currentIndex throws an assertion error", () {
        expect(
          () => MainTabsState(currentSelection: null),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then currentIndex stores the given index of the state", () {
        const testSelection = MainTabsSelection.colors;
        const testState = MainTabsState(currentSelection: testSelection);
        expect(testState.currentSelection, testSelection);
      });
    });
  });
}
