import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:flutter/material.dart';

class OnBoardingData extends InheritedWidget {
  const OnBoardingData({
    required this.state,
    required this.onPageScroll,
    required this.onFinished,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final OnBoardingState state;
  final void Function(double, double) onPageScroll;
  final void Function() onFinished;

  static OnBoardingData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: OnBoardingData);

  @override
  bool updateShouldNotify(OnBoardingData oldWidget) => state != oldWidget.state;
}
