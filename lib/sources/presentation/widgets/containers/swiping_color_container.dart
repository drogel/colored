import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:flutter/material.dart';

class SwipingColorContainer extends StatelessWidget {
  const SwipingColorContainer({
    @required this.onColorSwipedDown,
    @required this.onColorSwipedUp,
    @required this.onColorSwipedLeft,
    @required this.onColorSwipedRight,
    this.color,
    Key key,
  }) : super(key: key);

  final Color color;
  final void Function(double) onColorSwipedDown;
  final void Function(double) onColorSwipedUp;
  final void Function(double) onColorSwipedLeft;
  final void Function(double) onColorSwipedRight;

  @override
  Widget build(BuildContext context) => DirectionalPanDetector(
        onPanUpdateDown: (details) => onColorSwipedDown(details.delta.dy),
        onPanUpdateLeft: (details) => onColorSwipedLeft(details.delta.dx),
        onPanUpdateRight: (details) => onColorSwipedRight(details.delta.dx),
        onPanUpdateUp: (details) => onColorSwipedUp(details.delta.dy),
        child: Container(
          color: color,
        ),
      );
}
