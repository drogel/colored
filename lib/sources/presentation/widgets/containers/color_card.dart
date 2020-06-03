import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({
    @required this.backgroundColor,
    @required this.title,
    @required this.subtitle,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Color backgroundColor;
  final String title;
  final String subtitle;
  final void Function(Color) onPressed;

  @override
  Widget build(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final opacity = OpacityData.of(context).opacityScheme;
    final padding = PaddingData.of(context).paddingScheme;
    final radii = RadiusData.of(context).radiiScheme;
    return Padding(
      padding: padding.small,
      child: FloatingActionButton(
        onPressed: () => onPressed(backgroundColor),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radii.medium),
        ),
        backgroundColor: backgroundColor,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: padding.small,
            decoration: BoxDecoration(
              color: primaryColorDark.withOpacity(opacity.overlay),
              borderRadius: BorderRadius.all(radii.medium),
            ),
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ),
        ),
      ),
    );
  }
}
