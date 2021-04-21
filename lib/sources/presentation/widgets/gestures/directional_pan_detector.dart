import 'package:flutter/material.dart';

class DirectionalPanDetector extends StatelessWidget {
  const DirectionalPanDetector({
    required this.child,
    this.onPanUpdateDown,
    this.onPanUpdateRight,
    this.onPanUpdateLeft,
    this.onPanUpdateUp,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final void Function(DragUpdateDetails)? onPanUpdateDown;
  final void Function(DragUpdateDetails)? onPanUpdateUp;
  final void Function(DragUpdateDetails)? onPanUpdateRight;
  final void Function(DragUpdateDetails)? onPanUpdateLeft;

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
      if (onPanUpdateDown != null) {
        onPanUpdateDown!(details);
      }
    } else if (dy < 0) {
      if (onPanUpdateUp != null) {
        onPanUpdateUp!(details);
      }
    } else if (dx > 0) {
      if (onPanUpdateRight != null) {
        onPanUpdateRight!(details);
      }
    } else if (dx < 0) {
      if (onPanUpdateLeft != null) {
        onPanUpdateLeft!(details);
      }
    }
  }
}
