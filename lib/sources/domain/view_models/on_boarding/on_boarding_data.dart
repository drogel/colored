import 'package:flutter/material.dart';

class OnBoardingData extends InheritedWidget {
  const OnBoardingData({
    @required Widget child,
    Key key,
  })
      : assert(child != null),
        super(key: key, child: child);

  static OnBoardingData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: OnBoardingData);

  @override
  bool updateShouldNotify(OnBoardingData oldWidget) {
    // TODO(diego): implement updateShouldNotify in OnBoardingData
    return true;
  }
}