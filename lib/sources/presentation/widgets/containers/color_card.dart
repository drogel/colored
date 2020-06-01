import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'file:///D:/Programas/Flutter/colored/colored/lib/sources/app/styling/padding/padding_constants.dart' as paddings;
import 'package:colored/sources/app/styling/radii.dart' as radii;
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
    return Padding(
      padding: paddings.small,
      child: FloatingActionButton(
        onPressed: () => onPressed(backgroundColor),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.medium),
        ),
        backgroundColor: backgroundColor,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: primaryColorDark.withOpacity(opacity.overlay),
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
