import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:flutter/material.dart';

class SwipingColorContainer extends StatelessWidget {
  const SwipingColorContainer({
    @required this.onColorSwipedVertical,
    @required this.onColorSwipedHorizontal,
    this.color,
    Key key,
  }) : super(key: key);

  final Color color;
  final void Function(double) onColorSwipedVertical;
  final void Function(double) onColorSwipedHorizontal;

  @override
  Widget build(BuildContext context) => DirectionalPanDetector(
        onPanUpdateDown: (detail) => onColorSwipedVertical(detail.delta.dy),
        onPanUpdateLeft: (detail) => onColorSwipedHorizontal(detail.delta.dx),
        onPanUpdateRight: (detail) => onColorSwipedHorizontal(detail.delta.dx),
        onPanUpdateUp: (detail) => onColorSwipedVertical(detail.delta.dy),
        child: Container(
          color: color,
        ),
      );
}
