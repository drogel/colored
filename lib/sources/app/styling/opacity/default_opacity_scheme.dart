import 'package:colored/sources/app/styling/opacity/opacity_constants.dart'
    as opacity;
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';

class DefaultOpacityScheme implements OpacityScheme {
  const DefaultOpacityScheme();

  @override
  double get fadedColor => opacity.fadedColor;

  @override
  double get overlay => opacity.overlay;

  @override
  double get shadow => opacity.shadow;

  @override
  double get hover => opacity.hover;
}
