import 'package:flutter/material.dart';

class NoGlowBehavior extends ScrollBehavior {
  const NoGlowBehavior();

  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}
