import 'dart:async';

import 'package:colored/sources/app/styling/curves/curve_constants.dart'
    as curves;
import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

const _kTestMaxWidth = 100.0;

class MockOrientationService extends Mock implements DeviceOrientationService {}

void main() {
  late OnBoardingViewModel viewModel;
  late StreamController<OnBoardingState> stateController;

  setUp(() {
    stateController = StreamController<OnBoardingState>();
    viewModel = const OnBoardingInjector().injectViewModel(stateController);
  });

  tearDown(() {
    stateController.close();
  });

  void runScrollFractionTest({
    required OnBoardingState expectedState,
    required double scrollPosition,
    double maxWidth = _kTestMaxWidth,
  }) {
    stateController.stream.listen((state) => expect(state, expectedState));
    viewModel.computeScrollFraction(scrollPosition, maxWidth);
  }

  group("Given an OnBoardingViewModel", () {
    group("when initialState is called", () {
      test("then an OnBoardingState with 0 pageScrollFraction is returned", () {
        final actual = viewModel.initialState;

        expect(actual, isA<OnBoardingState>());
        expect(actual.pageScrollFraction, 0);
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when computeScrollFraction is called", () {
      group("with bounding scroll values", () {
        test("then a new state with zero pageScrollFraction is retrieved", () {
          runScrollFractionTest(
            expectedState: const OnBoardingState(pageScrollFraction: 0),
            scrollPosition: 0,
          );
        });

        test("then a new state with the pageScrollFraction is retrieved", () {
          runScrollFractionTest(
            expectedState: const OnBoardingState(pageScrollFraction: 3),
            scrollPosition: 3 * _kTestMaxWidth,
          );
        });
      });

      group("with in-between scroll values", () {
        test("then a new state with right pageScrollFraction is retrieved", () {
          final scrollFractionInCurve = curves.exiting.transform(0.5);
          runScrollFractionTest(
            expectedState: OnBoardingState(
              pageScrollFraction: scrollFractionInCurve,
            ),
            scrollPosition: _kTestMaxWidth / 2,
          );
        });
      });
    });
  });
}
