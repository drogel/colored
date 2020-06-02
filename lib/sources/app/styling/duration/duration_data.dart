import 'package:colored/sources/app/styling/duration/duration_scheme.dart';
import 'package:flutter/material.dart';

class DurationData extends InheritedWidget {
  const DurationData({
    @required this.durationScheme,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(durationScheme != null),
        super(key: key, child: child);

  final DurationScheme durationScheme;

  static DurationData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: DurationData);

  @override
  bool updateShouldNotify(DurationData oldWidget) =>
      durationScheme != oldWidget.durationScheme;
}
