import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/material.dart';

class DefaultAnimatedSwitcher extends StatelessWidget {
  const DefaultAnimatedSwitcher({@required this.child, Key key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final duration = DurationData.of(context).durationScheme;
    final curves = CurveData.of(context).curveScheme;
    return AnimatedSwitcher(
      switchInCurve: curves.incoming,
      switchOutCurve: curves.exiting,
      duration: duration.mediumPresenting,
      reverseDuration: duration.mediumDismissing,
      child: child,
    );
  }
}
