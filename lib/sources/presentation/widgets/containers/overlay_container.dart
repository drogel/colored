import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
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
    final radii = RadiusData.of(context).radiiScheme;
    final padding = PaddingData.of(context).paddingScheme;
    final defaultPadding = EdgeInsets.symmetric(vertical: padding.medium.top);
    final opacity = OpacityData.of(context).opacityScheme;
    return Container(
      padding: this.padding ?? defaultPadding,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(opacity.overlay),
        borderRadius: BorderRadius.only(
          topLeft: radii.large,
          topRight: radii.large,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(opacity.shadow),
            offset: const Offset(0, -2),
            blurRadius: 4,
          )
        ],
      ),
      child: child,
    );
  }
}
