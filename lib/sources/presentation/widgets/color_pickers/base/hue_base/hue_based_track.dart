import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class HueBasedTrack extends StatelessWidget {
  const HueBasedTrack({
    required this.painter,
    Key? key,
  }) : super(key: key);

  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context)!.radiiScheme;
    return SizedBox.expand(
      child: ClipRRect(
        borderRadius: BorderRadius.all(radii.medium),
        child: CustomPaint(painter: painter),
      ),
    );
  }
}
