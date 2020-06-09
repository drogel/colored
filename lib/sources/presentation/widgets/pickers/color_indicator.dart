import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  const ColorIndicator({
    @required this.color,
    @required this.outerColor,
    this.size = 48,
    Key key,
  })  : assert(color != null),
        assert(outerColor != null),
        super(key: key);

  final Color color;
  final Color outerColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(size / 2);
    final padding = PaddingData.of(context).paddingScheme;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: outerColor, borderRadius: borderRadius),
      child: Container(
        margin: padding.small,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      ),
    );
  }
}
