import 'package:animations/animations.dart';
import 'package:colored/sources/app/styling/duration/duration_constants.dart'
    as duration;
import 'package:flutter/material.dart';

class PageTransitionRoute<T> extends PageRoute<T> {
  PageTransitionRoute({
    required this.builder,
    RouteSettings? settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final Widget Function(BuildContext) builder;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      builder(context);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );

  @override
  final bool maintainState;

  @override
  Duration get transitionDuration => duration.longPresenting;
}
