import 'package:flutter/material.dart';

class SwipingColorContainer extends StatelessWidget {
  const SwipingColorContainer({
    this.onColorSwipedVertical,
    this.onColorSwipedHorizontal,
    this.onColorSwipeStart,
    this.onColorSwipeEnd,
    this.color,
    Key? key,
  }) : super(key: key);

  final Color? color;
  final void Function(double)? onColorSwipedVertical;
  final void Function(double)? onColorSwipedHorizontal;
  final void Function()? onColorSwipeStart;
  final void Function()? onColorSwipeEnd;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragStart: _onDragStart,
        onVerticalDragStart: _onDragStart,
        onHorizontalDragEnd: _onDragEnd,
        onVerticalDragEnd: _onDragEnd,
        child: Container(color: color),
      );

  void _onDragStart(DragStartDetails details) {
    if (onColorSwipeStart != null) {
      onColorSwipeStart!();
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (onColorSwipeEnd != null) {
      onColorSwipeEnd!();
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (onColorSwipedVertical != null) {
      onColorSwipedVertical!(details.delta.dy);
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (onColorSwipedHorizontal != null) {
      onColorSwipedHorizontal!(details.delta.dx);
    }
  }
}
