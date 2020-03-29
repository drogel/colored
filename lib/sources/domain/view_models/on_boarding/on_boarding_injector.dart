import 'dart:async';

import 'package:colored/sources/data/services/device_orientation/system_chrome_service.dart';
import 'package:colored/sources/data/services/local_storage/shared_preferences.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';

class OnBoardingInjector {
  const OnBoardingInjector();

  OnBoardingViewModel injectViewModel([
    StreamController<OnBoardingState> stateController,
  ]) =>
      OnBoardingViewModel(
        stateController: stateController ?? StreamController<OnBoardingState>(),
        deviceOrientationService: const SystemChromeService(),
        localStorage: const SharedPreferences(),
      );
}
