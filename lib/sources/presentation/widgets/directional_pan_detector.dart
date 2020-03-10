import 'package:flutter/material.dart';

class DirectionalPanDetector extends StatelessWidget {
  const DirectionalPanDetector({
    @required this.child,
    this.onPanUpdateDownDirection,
    this.onPanUpdateRightDirection,
    this.onPanUpdateLeftDirection,
    this.onPanUpdateUpDirection,
    Key key,
  }) : super(key: key);

  final Widget child;
  final void Function(DragUpdateDetails) onPanUpdateDownDirection;
  final void Function(DragUpdateDetails) onPanUpdateUpDirection;
  final void Function(DragUpdateDetails) onPanUpdateRightDirection;
  final void Function(DragUpdateDetails) onPanUpdateLeftDirection;

  @override
  Widget build(BuildContext context) =>
      GestureDetector(
        onVerticalDragUpdate: _notifyPanDirection,
        onHorizontalDragUpdate: _notifyPanDirection,
        child: child,
      );

  void _notifyPanDirection(DragUpdateDetails details) {
    final dy = details.delta.dy;
    final dx = details.delta.dx;

    if (dy > 0) {
      if (onPanUpdateDownDirection != null) {
        onPanUpdateDownDirection(details);
      }
    } else if (dy < 0) {
      if (onPanUpdateUpDirection != null) {
        onPanUpdateUpDirection(details);
      }
    } else if (dx > 0) {
      if (onPanUpdateRightDirection != null) {
        onPanUpdateRightDirection(details);
      }
    } else if (dx < 0) {
      if (onPanUpdateLeftDirection != null) {
        onPanUpdateLeftDirection(details);
      }
    }
  }
}
