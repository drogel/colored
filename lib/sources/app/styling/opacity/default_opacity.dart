import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:colored/sources/app/styling/opacity/opacity_constants.dart' as opacity;

class DefaultOpacity implements OpacityScheme {
  const DefaultOpacity();

  @override
  double get fadedColor => opacity.fadedColor;

  @override
  double get overlay => opacity.overlay;

  @override
  double get shadow => opacity.shadow;
}