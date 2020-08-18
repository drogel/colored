import 'package:colored/sources/app/styling/curves/curve_scheme.dart';
import 'package:flutter/material.dart';

class CurveData extends InheritedWidget {
  const CurveData({
    @required this.curveScheme,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(curveScheme != null),
        super(key: key, child: child);

  final CurveScheme curveScheme;

  static CurveData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: CurveData);

  @override
  bool updateShouldNotify(CurveData oldWidget) =>
      oldWidget.curveScheme != curveScheme;
}
