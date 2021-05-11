import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class FloatingCard extends StatelessWidget {
  const FloatingCard({this.child, this.backgroundColor, Key? key})
      : super(key: key);

  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context)!.radiiScheme;
    final borderRadius = BorderRadius.all(radii.large);
    final padding = PaddingData.of(context)!.paddingScheme;
    return Padding(
      padding: padding.small,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: backgroundColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: child,
      ),
    );
  }
}
