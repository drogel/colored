import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_data.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_state.dart';
import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/material.dart';

class ConnectivityBar extends StatelessWidget {
  const ConnectivityBar({
    Key key,
    this.child,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final elevation = ElevationData.of(context).elevationScheme;
    final colors = Theme.of(context).colorScheme;
    final state = ConnectivityData.of(context).state;
    final curves = CurveData.of(context).curveScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final durations = DurationData.of(context).durationScheme;
    final paddingScheme = PaddingData.of(context).paddingScheme;
    final opacity = OpacityData.of(context).opacityScheme;
    final crossFadeState = _getCrossFadeState(state);
    return Padding(
      padding: paddingScheme.small,
      child: Material(
        elevation: elevation.low,
        color: backgroundColor ?? colors.primary.withOpacity(opacity.overlay),
        borderRadius: BorderRadius.all(radii.medium),
        child: AnimatedCrossFade(
          crossFadeState: crossFadeState,
          duration: durations.mediumPresenting,
          firstCurve: curves.exiting,
          secondCurve: curves.exiting,
          sizeCurve: curves.incoming,
          firstChild: SizedBox(width: double.maxFinite),
          secondChild: Padding(
            padding: paddingScheme.medium,
            child: child,
          ),
        ),
      ),
    );
  }

  CrossFadeState _getCrossFadeState(ConnectivityState state) =>
      state is NoConnection
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
}
