import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    this.child,
    this.padding,
    Key key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final elevation = ElevationData.of(context).elevationScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final padding = PaddingData.of(context).paddingScheme;
    final deviceSafeArea = MediaQuery.of(context).padding;
    final opacity = OpacityData.of(context).opacityScheme;
    return SafeArea(
      child: OrientationBuilder(
        builder: (_, orientation) => Padding(
          padding: _getOuterPadding(orientation, deviceSafeArea, padding),
          child: Material(
            elevation: elevation.low,
            color: colors.primary.withOpacity(opacity.overlay),
            borderRadius: BorderRadius.all(radii.large),
            child: child,
          ),
        ),
      ),
    );
  }

  EdgeInsets _getOuterPadding(
    Orientation orientation,
    EdgeInsets deviceSafeArea,
    PaddingScheme paddingScheme,
  ) {
    if (kIsWeb) {
      return paddingScheme.large;
    } else {
      if (orientation == Orientation.portrait) {
        return deviceSafeArea.bottom == 0
            ? paddingScheme.small
            : EdgeInsets.symmetric(horizontal: deviceSafeArea.bottom / 2);
      } else {
        return paddingScheme.small;
      }
    }
  }
}
