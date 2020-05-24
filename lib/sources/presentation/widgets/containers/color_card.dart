import 'package:colored/sources/app/styling/padding.dart' as paddings;
import 'package:colored/sources/app/styling/radii.dart' as radii;
import 'package:colored/sources/app/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  Widget build(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    return Padding(
      padding: paddings.card,
      child: FloatingActionButton(
        onPressed: () {},
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.medium),
        ),
        backgroundColor: backgroundColor,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: primaryColorDark.withOpacity(opacities.overlay),
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
