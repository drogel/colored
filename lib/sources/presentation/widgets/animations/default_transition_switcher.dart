import 'package:animations/animations.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/material.dart';

class DefaultTransitionSwitcher extends StatelessWidget {
  const DefaultTransitionSwitcher({
    @required this.child,
    this.backgroundColor,
    Key key,
  })  : assert(child != null),
        super(key: key);

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final durations = DurationData.of(context).durationScheme;
    final defaultBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return PageTransitionSwitcher(
      duration: durations.longPresenting,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          _buildTransition(
        primaryAnimation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        defaultBackgroundColor: defaultBackgroundColor,
        child: child,
      ),
      child: child,
    );
  }

  Widget _buildTransition({
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
    Color defaultBackgroundColor,
    Widget child,
  }) =>
      Container(
        color: backgroundColor ?? defaultBackgroundColor,
        child: FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );
}
