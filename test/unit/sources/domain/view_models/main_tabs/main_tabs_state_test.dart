import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a MainTabsState", () {
    group("when constructed", () {
      test("then passing a null currentIndex throws an assertion error", () {
        expect(
          () => MainTabsState(currentIndex: null),
          throwsA(isA<AssertionError>()),
        );
      });

      test("then currentIndex stores the given index of the state", () {
        const testIndex = 1;
        const testState = MainTabsState(currentIndex: testIndex);
        expect(testState.currentIndex, testIndex);
      });
    });
  });
}
