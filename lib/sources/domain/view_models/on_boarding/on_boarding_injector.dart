import 'dart:async';

import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';

class OnBoardingInjector {
  const OnBoardingInjector();

  OnBoardingViewModel injectViewModel() => OnBoardingViewModel(
        stateController: StreamController<OnBoardingState>(),
      );
}
