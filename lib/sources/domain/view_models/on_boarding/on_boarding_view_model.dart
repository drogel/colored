import 'dart:async';

import 'package:colored/sources/app/styling/curves/curve_constants.dart'
    as curves;
import 'package:colored/sources/common/extensions/extended_curve.dart';
import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';

class OnBoardingViewModel {
  const OnBoardingViewModel({
    required StreamController<OnBoardingState> stateController,
    required DeviceOrientationService deviceOrientationService,
    required LocalStorage localStorage,
  })   : _localStorage = localStorage,
        _deviceOrientationService = deviceOrientationService,
        _stateController = stateController;

  final StreamController<OnBoardingState> _stateController;
  final DeviceOrientationService _deviceOrientationService;
  final LocalStorage _localStorage;

  Stream<OnBoardingState> get stateStream => _stateController.stream;

  OnBoardingState get initialState =>
      const OnBoardingState(pageScrollFraction: 0);

  void init() => _deviceOrientationService.setPortraitOrientation();

  void computeScrollFraction(double scrollPosition, double maxWidth) {
    final scrollFraction = scrollPosition / maxWidth;
    final fraction = curves.exiting.extendedTransform(scrollFraction);
    _stateController.sink.add(OnBoardingState(pageScrollFraction: fraction));
  }

  Future<void> onOnBoardingFinish() async => _localStorage.storeBool(
        key: keys.didOnBoard,
        value: true,
      );

  void dispose() => _stateController.close();
}
