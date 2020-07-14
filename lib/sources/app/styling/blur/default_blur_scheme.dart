import 'package:colored/sources/app/styling/blur/blur_constants.dart' as blurs;
import 'package:colored/sources/app/styling/blur/blur_scheme.dart';
import 'package:colored/sources/app/styling/blur/blur_sigma.dart';

class DefaultBlurScheme implements BlurScheme {
  const DefaultBlurScheme();

  @override
  BlurSigma get medium => const BlurSigma(
        x: blurs.mediumSigmaX,
        y: blurs.mediumSigmaY,
      );
}
