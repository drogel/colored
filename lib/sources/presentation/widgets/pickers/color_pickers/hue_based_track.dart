import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/cupertino.dart';

class HueBasedTrack extends StatelessWidget {
  const HueBasedTrack({
    @required this.painter,
    Key key,
  })  : assert(painter != null),
        super(key: key);

  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context).radiiScheme;
    return ClipRRect(
      borderRadius: BorderRadius.all(radii.medium),
      child: CustomPaint(painter: painter),
    );
  }
}
