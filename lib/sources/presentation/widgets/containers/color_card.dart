import 'package:colored/sources/app/styling/radii.dart' as radii;
import 'package:colored/sources/app/styling/opacities.dart' as opacities;
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
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.medium),
        ),
        color: backgroundColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              color:
                  Theme.of(context).primaryColor.withOpacity(opacities.overlay),
              child: ListTile(
                title: Text(title),
                subtitle: Text(subtitle),
              ),
            ),
          ],
        ),
      );
}