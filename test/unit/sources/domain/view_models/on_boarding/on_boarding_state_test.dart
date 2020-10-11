import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given an OnBoardingState", () {
    group("when constructed", () {
      test("then an error is thrown if pageScrollFraction is null", () {
        expect(
          () => OnBoardingState(pageScrollFraction: null),
          throwsAssertionError,
        );
      });
    });

    group("when checking for equality", () {
      test("then two states are equal if pageScrollFractions are equal", () {
        const firstState = OnBoardingState(pageScrollFraction: 0.5);
        const secondState = OnBoardingState(pageScrollFraction: 0.5);

        expect(firstState == secondState, isTrue);
      });

      test("then two states are not equal if pageScrollFractions differ", () {
        const firstState = OnBoardingState(pageScrollFraction: 1.5);
        const secondState = OnBoardingState(pageScrollFraction: 0.5);

        expect(firstState == secondState, isFalse);
      });

      test("the hashCode is based on the pageScrollFraction hashcode", () {
        const scrollFraction = 1.0;
        const state = OnBoardingState(pageScrollFraction: scrollFraction);

        expect(state.hashCode, scrollFraction.hashCode);
      });
    });
  });
}
