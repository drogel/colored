import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class ColorCardTile extends StatelessWidget {
  const ColorCardTile({
    @required this.title,
    @required this.subtitle,
    this.borderRadius,
    Key key,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final opacity = OpacityData.of(context).opacityScheme;
    final padding = PaddingData.of(context).paddingScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final parentRadius = borderRadius ?? BorderRadius.all(radii.large);
    final titleMargin = padding.small;
    final marginBorderRadius = BorderRadius.circular(titleMargin.left);
    return Container(
      margin: titleMargin,
      decoration: BoxDecoration(
        color: primaryColorDark.withOpacity(opacity.overlay),
        borderRadius: parentRadius.subtract(marginBorderRadius),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
