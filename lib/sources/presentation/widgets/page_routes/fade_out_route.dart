import 'package:colored/sources/app/styling/curves.dart' as curves;
import 'package:colored/sources/app/styling/durations.dart' as durations;
import 'package:flutter/material.dart';

class FadeOutRoute<T> extends PageRoute<T> {
  FadeOutRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final Widget Function(BuildContext) builder;

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
      builder(context);

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
