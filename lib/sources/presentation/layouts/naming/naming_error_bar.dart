import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/domain/view_models/naming/naming_data.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:flutter/material.dart';

class NamingErrorBar extends StatelessWidget {
  const NamingErrorBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context).naming;
    final elevation = ElevationData.of(context).elevationScheme;
    final bodyTextStyle = Theme.of(context).textTheme.bodyText1;
    final colors = Theme.of(context).colorScheme;
    final namingState = NamingData.of(context).state;
    final curves = CurveData.of(context).curveScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final durations = DurationData.of(context).durationScheme;
    final paddingScheme = PaddingData.of(context).paddingScheme;
    final crossFadeState = _getCrossFadeState(namingState);
    return Padding(
      padding: paddingScheme.small,
      child: Material(
        elevation: elevation.low,
        color: colors.error,
        borderRadius: BorderRadius.all(radii.medium),
        child: AnimatedCrossFade(
          crossFadeState: crossFadeState,
          duration: durations.mediumPresenting,
          firstCurve: curves.exiting,
          secondCurve: curves.exiting,
          sizeCurve: curves.incoming,
          firstChild: Row(
            mainAxisSize: MainAxisSize.max,
            children: const <Widget>[SizedBox()],
          ),
          secondChild: Padding(
            padding: paddingScheme.medium,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.offline_bolt,
                  size: bodyTextStyle.fontSize + 3,
                  color: colors.onError,
                ),
                SizedBox(width: paddingScheme.large.top),
                Text(localization.noConnection),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CrossFadeState _getCrossFadeState(NamingState namingState) =>
      namingState is NoConnectivity
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
}
