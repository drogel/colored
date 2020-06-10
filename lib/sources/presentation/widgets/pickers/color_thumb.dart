import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
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
    final opacity = OpacityData.of(context).opacityScheme;
    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(radii.large),
                color: Colors.white.withOpacity(opacity.fadedColor),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight / 2,
            width: constraints.maxWidth / 2,
            child: Material(
              elevation: elevation.low,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radii.large),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
