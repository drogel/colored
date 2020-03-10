import 'package:colored/sources/presentation/widgets/directional_pan_detector.dart';
import 'package:flutter/material.dart';

class SwipingColorContainer extends StatelessWidget {
  const SwipingColorContainer({this.color, Key key}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) => DirectionalPanDetector(
        onPanUpdateDownDirection: (_) => print("down"),
        onPanUpdateLeftDirection: (_) => print("left"),
        onPanUpdateRightDirection: (_) => print("right"),
        onPanUpdateUpDirection: (_) => print("up"),
        child: Container(
          color: color,
        ),
      );
}
