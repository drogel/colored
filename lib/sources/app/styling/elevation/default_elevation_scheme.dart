import 'package:colored/sources/app/styling/elevation/elevation_constants.dart' as elevation;
import 'package:colored/sources/app/styling/elevation/elevation_scheme.dart';

class DefaultElevationScheme implements ElevationScheme {
  const DefaultElevationScheme();

  @override
  double get high => elevation.high;

  @override
  double get low => elevation.low;

  @override
  double get medium => elevation.medium;
}