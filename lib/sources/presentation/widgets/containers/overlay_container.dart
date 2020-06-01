import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/radii.dart' as radii;
import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    this.child,
    this.padding = const EdgeInsets.only(top: radii.small, bottom: radii.large),
    Key key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final opacity = OpacityData.of(context).opacityScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(opacity.overlay),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(radii.large),
          topRight: Radius.circular(radii.large),
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
