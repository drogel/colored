import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/presentation/widgets/containers/color_card_tile.dart';
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
    final padding = PaddingData.of(context).paddingScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.large);
    return Padding(
      padding: padding.medium,
      child: FloatingActionButton(
        onPressed: () => onPressed(backgroundColor),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        backgroundColor: backgroundColor,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ColorCardTile(
            title: title,
            subtitle: subtitle,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
