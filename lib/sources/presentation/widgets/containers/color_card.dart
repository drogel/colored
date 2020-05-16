import 'package:colored/sources/app/styling/radii.dart' as radii;
import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({
    @required this.backgroundColor,
    @required this.title,
    @required this.subtitle,
    Key key,

  }) : super(key: key);

  final Color backgroundColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.medium),
        ),
        color: backgroundColor,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      );
}
