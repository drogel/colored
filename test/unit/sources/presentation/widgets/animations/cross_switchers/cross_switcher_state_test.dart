import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CrossSwitcherState state;

  group("Given a CrossSwitcherState", () {
    group("when switched is called", () {
      test("returns showFirst if state was showSecond", () {
        state = CrossSwitcherState.showSecond;
        final actual = state.switched();
        expect(actual, CrossSwitcherState.showFirst);
      });

      test("returns showSecond if state was showFirst", () {
        state = CrossSwitcherState.showFirst;
        final actual = state.switched();
        expect(actual, CrossSwitcherState.showSecond);
      });
    });
  });
}