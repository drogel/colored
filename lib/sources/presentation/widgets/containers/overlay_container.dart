import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final elevation = ElevationData.of(context).elevationScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final padding = PaddingData.of(context).paddingScheme;
    final defaultPaddingValue = padding.large.bottom + padding.small.bottom;
    final defaultPadding = EdgeInsets.only(bottom: defaultPaddingValue);
    final deviceSafeArea = MediaQuery.of(context).padding;
    final opacity = OpacityData.of(context).opacityScheme;
    return SafeArea(
      child: OrientationBuilder(
        builder: (_, orientation) => Padding(
          padding: _getPadding(orientation, deviceSafeArea, padding),
          child: Material(
            elevation: elevation.low,
            color: colorScheme.primary.withOpacity(opacity.overlay),
            borderRadius: BorderRadius.all(radii.large),
            child: Padding(
              padding: this.padding ?? defaultPadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _getPadding(
    Orientation orientation,
    EdgeInsets deviceSafeArea,
    PaddingScheme paddingScheme,
  ) {
    if (orientation == Orientation.portrait) {
      return deviceSafeArea.bottom == 0
          ? paddingScheme.small
          : EdgeInsets.symmetric(horizontal: deviceSafeArea.bottom / 2);
    } else {
      return paddingScheme.small;
    }
  }
}
