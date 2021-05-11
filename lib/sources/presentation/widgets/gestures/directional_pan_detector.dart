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
  Widget build(BuildContext context) => GestureDetector(
        onVerticalDragUpdate: _notifyPanDirection,
        onHorizontalDragUpdate: _notifyPanDirection,
        child: child,
      );

  void _notifyPanDirection(DragUpdateDetails details) {
    final dy = details.delta.dy;
    final dx = details.delta.dx;

    if (dy > 0) {
      _notifyGesture(onPanUpdateDown, details);
    } else if (dy < 0) {
      _notifyGesture(onPanUpdateUp, details);
    } else if (dx > 0) {
      _notifyGesture(onPanUpdateRight, details);
    } else if (dx < 0) {
      _notifyGesture(onPanUpdateLeft, details);
    }
  }

  void _notifyGesture(
    void Function(DragUpdateDetails)? notifier,
    DragUpdateDetails details,
  ) {
    if (notifier != null) {
      notifier(details);
    }
  }
}
