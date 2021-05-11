import 'dart:async';

import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OnBoardingInjector injector;

  setUp(() {
    injector = const OnBoardingInjector();
  });

  group("Given an OnBoardingInjector", () {
    group("when injectViewModel is called", () {
      test("then the provided stateController is given to the viewModel", () {
        final stateController = StreamController<OnBoardingState>();

        final viewModel = injector.injectViewModel(stateController);

        expect(viewModel.stateStream, stateController.stream);
      });

      test("a default stateController is provided if none is passed", () {
        final viewModel = injector.injectViewModel();

        expect(viewModel.stateStream, isNotNull);
      });
    });
  });
}
