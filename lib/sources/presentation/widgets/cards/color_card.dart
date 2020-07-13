import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/presentation/widgets/cards/color_card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColorCard extends StatefulWidget {
  const ColorCard({
    @required this.title,
    @required this.subtitle,
    this.onPressed,
    this.child,
    Key key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget child;
  final void Function() onPressed;

  @override
  _ColorCardState createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
  double _elevation;

  @override
  void didChangeDependencies() {
    _elevation = ElevationData.of(context).elevationScheme.low;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.large);
    return Padding(
      padding: padding.medium,
      child: Material(
        elevation: _elevation,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Stack(
          children: [
            widget.child,
            Material(
              color: Colors.transparent,
              child: InkWell(onTap: widget.onPressed),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ColorCardTile(
                title: widget.title,
                subtitle: widget.subtitle,
                borderRadius: borderRadius,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
