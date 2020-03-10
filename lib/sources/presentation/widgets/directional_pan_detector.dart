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
  Widget build(BuildContext context) => GestureDetector(
        onPanUpdate: _handlePanDirection,
        child: child,
      );

  void _handlePanDirection(DragUpdateDetails details) {
    final dy = details.delta.dy;
    final dx = details.delta.dx;
    final isMainlyHorizontal = dx.abs() - dy.abs() > 0;
    if (dy > 0 && !isMainlyHorizontal) {
      if (onPanUpdateDownDirection != null) {
        onPanUpdateDownDirection(details);
      }
    } else if (dy < 0 && !isMainlyHorizontal) {
      if (onPanUpdateUpDirection != null) {
        onPanUpdateUpDirection(details);
      }
    } else if (dx > 0 && isMainlyHorizontal) {
      if (onPanUpdateRightDirection != null) {
        onPanUpdateRightDirection(details);
      }
    } else if (dx < 0 && isMainlyHorizontal) {
      if (onPanUpdateLeftDirection != null) {
        onPanUpdateLeftDirection(details);
      }
    }
  }
}
