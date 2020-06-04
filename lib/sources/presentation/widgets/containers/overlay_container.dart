import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kIndicatorHeight = 5;

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    this.child,
    this.padding,
    this.hasIndicator = true,
    Key key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final bool hasIndicator;

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
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Material(
                elevation: elevation.low,
                color: colors.primary.withOpacity(opacity.overlay),
                borderRadius: BorderRadius.all(radii.large),
                child: Padding(
                  padding: this.padding ?? _getInnerPadding(padding),
                  child: child,
                ),
              ),
              if (hasIndicator)
                Container(
                  width: 36,
                  height: _kIndicatorHeight,
                  margin: const EdgeInsets.all(_kIndicatorHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(radii.small),
                    color: theme.buttonColor,
                  ),
                ),
            ],
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

  EdgeInsets _getInnerPadding(PaddingScheme padding) {
    final defaultPaddingValue = padding.large.bottom + padding.small.top;
    return EdgeInsets.only(bottom: defaultPaddingValue, top: padding.small.top);
  }
}
