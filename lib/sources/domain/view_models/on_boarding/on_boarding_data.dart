import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:flutter/material.dart';

class OnBoardingData extends InheritedWidget {
  const OnBoardingData({
    @required this.state,
    @required this.onPageScroll,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(onPageScroll != null),
        assert(state != null),
        super(key: key, child: child);

  final OnBoardingState state;
  final void Function(double, double) onPageScroll;

  static OnBoardingData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: OnBoardingData);

  @override
  bool updateShouldNotify(OnBoardingData oldWidget) => state != oldWidget.state;
}
