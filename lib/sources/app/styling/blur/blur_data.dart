import 'package:colored/sources/app/styling/blur/blur_scheme.dart';
import 'package:flutter/material.dart';

class BlurData extends InheritedWidget {
  const BlurData({
    @required this.blurScheme,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(blurScheme != null),
        super(key: key, child: child);

  final BlurScheme blurScheme;

  static BlurData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: BlurData);

  @override
  bool updateShouldNotify(BlurData oldWidget) =>
      oldWidget.blurScheme != blurScheme;
}
