import 'package:animations/animations.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/material.dart';

enum PageTransitionType {
  fadeThrough,
  sharedZAxis,
}

class TransitionSwitcher extends StatelessWidget {
  const TransitionSwitcher({
    @required this.child,
    this.reverse = false,
    this.type = PageTransitionType.fadeThrough,
    this.backgroundColor,
    Key key,
  })  : assert(child != null),
        super(key: key);

  final Color backgroundColor;
  final Widget child;
  final bool reverse;
  final PageTransitionType type;

  @override
  Widget build(BuildContext context) {
    final durations = DurationData.of(context).durationScheme;
    final defaultBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return PageTransitionSwitcher(
      reverse: reverse,
      duration: durations.longPresenting,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          type == PageTransitionType.fadeThrough
              ? _buildFadeThrough(
                  primaryAnimation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  defaultBackgroundColor: defaultBackgroundColor,
                  child: child,
                )
              : _buildSharedZAxis(
                  primaryAnimation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  defaultBackgroundColor: defaultBackgroundColor,
                  child: child,
                ),
      child: child,
    );
  }

  Widget _buildFadeThrough({
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
    Color defaultBackgroundColor,
    Widget child,
  }) =>
      FadeThroughTransition(
        fillColor: backgroundColor ?? defaultBackgroundColor,
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );

  Widget _buildSharedZAxis({
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
    Color defaultBackgroundColor,
    Widget child,
  }) =>
      SharedAxisTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled,
        fillColor: backgroundColor ?? defaultBackgroundColor,
        child: child,
      );
}
