import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class ColorPickerLayout extends StatelessWidget {
  const ColorPickerLayout({
    @required this.height,
    @required this.child,
    Key key,
  })  : assert(height != null),
        assert(child != null),
        super(key: key);

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    return Padding(
      padding: EdgeInsets.only(
        top: padding.base,
        left: padding.base + padding.small.left,
        right: padding.base + padding.small.right,
        bottom: padding.medium.bottom + padding.small.bottom,
      ),
      child: SizedBox(
        height: height,
        child: child,
      ),
    );
  }
}
