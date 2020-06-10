import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class ColorThumb extends StatelessWidget {
  const ColorThumb({
    @required this.color,
    Key key,
  })  : assert(color != null),
        super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context).radiiScheme;
    final elevation = ElevationData.of(context).elevationScheme;
    return Material(
      elevation: elevation.low,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radii.large),
      ),
    );
  }
}
