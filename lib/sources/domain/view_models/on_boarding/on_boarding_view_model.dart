import 'dart:async';

import 'package:colored/sources/app/styling/curves.dart' as curves;
import 'package:colored/sources/common/extensions/extended_curve.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:flutter/foundation.dart';

class OnBoardingViewModel {
  const OnBoardingViewModel({
    @required StreamController<OnBoardingState> stateController,
  })  : assert(stateController != null),
        _stateController = stateController;

  final StreamController<OnBoardingState> _stateController;

  Stream<OnBoardingState> get stateStream => _stateController.stream;

  OnBoardingState get initialData =>
      const OnBoardingState(pageScrollFraction: 0);

  void computeScrollFraction(double scrollPosition, double maxWidth) {
    final scrollFraction = scrollPosition / maxWidth;
    final fraction = curves.easeInExpo.extendedTransform(scrollFraction);
    _stateController.sink.add(OnBoardingState(pageScrollFraction: fraction));
  }

  void dispose() => _stateController.close();
}
