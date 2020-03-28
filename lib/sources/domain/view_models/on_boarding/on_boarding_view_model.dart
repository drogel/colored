import 'dart:async';

import 'package:colored/sources/app/styling/curves.dart' as curves;
import 'package:colored/sources/common/extensions/extended_curve.dart';
import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:flutter/foundation.dart';

class OnBoardingViewModel {
  const OnBoardingViewModel({
    @required StreamController<OnBoardingState> stateController,
    @required DeviceOrientationService deviceOrientationService,
  })  : assert(stateController != null),
        assert(deviceOrientationService != null),
        _deviceOrientationService = deviceOrientationService,
        _stateController = stateController;

  final StreamController<OnBoardingState> _stateController;
  final DeviceOrientationService _deviceOrientationService;

  Stream<OnBoardingState> get stateStream => _stateController.stream;

  OnBoardingState get initialData =>
      const OnBoardingState(pageScrollFraction: 0);

  void init() => _deviceOrientationService.setPortraitOrientation();

  void computeScrollFraction(double scrollPosition, double maxWidth) {
    final scrollFraction = scrollPosition / maxWidth;
    final fraction = curves.exiting.extendedTransform(scrollFraction);
    _stateController.sink.add(OnBoardingState(pageScrollFraction: fraction));
  }

  void dispose() => _stateController.close();
}
