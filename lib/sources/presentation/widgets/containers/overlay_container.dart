import 'dart:ui';

import 'package:colored/sources/app/styling/blur/blur_data.dart';
import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    this.child,
    this.elevation,
    this.borderRadius,
    Key key,
  }) : super(key: key);

  final Widget child;
  final double elevation;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final elevationScheme = ElevationData.of(context).elevationScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final opacity = OpacityData.of(context).opacityScheme;
    final blur = BlurData.of(context).blurScheme.medium;
    final borderRadius = this.borderRadius ?? BorderRadius.all(radii.large);
    return Material(
      elevation: elevation ?? elevationScheme.low,
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur.x, sigmaY: blur.y),
          child: Container(
            color: colors.primary.withOpacity(opacity.overlay),
            child: child,
          ),
        ),
      ),
    );
  }
}
