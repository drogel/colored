import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a MainTabsState", () {
    group("when constructed", () {
      test("then passing a null currentIndex throws an assertion error", () {
        expect(
          () => IndexedNavigationState(null),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then currentIndex stores the given index of the state", () {
        const testSelection = MainTabsSelection.colors;
        final testState = IndexedNavigationState(testSelection.index);
        expect(testState.currentIndex, testSelection.index);
      });
    });
  });
}
