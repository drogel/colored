import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class LoadingTextCover extends StatelessWidget {
  const LoadingTextCover({
    this.parentWidthFraction = 1,
    this.coveringTextStyle,
    Key? key,
  }) : super(key: key);

  final double parentWidthFraction;
  final TextStyle? coveringTextStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = RadiusData.of(context)!.radiiScheme;
    final textStyle = coveringTextStyle ?? theme.textTheme.caption;
    final color = textStyle?.color ?? theme.colorScheme.onBackground;
    final height = textStyle?.fontSize ?? 12;
    return FractionallySizedBox(
      widthFactor: parentWidthFraction,
      alignment: Alignment.centerLeft,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(radius.small),
        ),
      ),
    );
  }
}
