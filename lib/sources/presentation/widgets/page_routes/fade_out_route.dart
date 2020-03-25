import 'package:colored/sources/app/styling/curves.dart' as curves;
import 'package:colored/sources/app/styling/durations.dart' as durations;
import 'package:flutter/material.dart';

class FadeOutRoute<T> extends PageRoute<T> {
  FadeOutRoute({
    @required this.enterWidget,
    this.maintainState = true,
  });

  final Widget enterWidget;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      enterWidget;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: curves.incoming,
          ),
        ),
        child: child,
      );

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => durations.longPresenting;
}
