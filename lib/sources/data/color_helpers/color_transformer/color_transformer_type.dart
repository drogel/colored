import 'package:colored/sources/domain/data_models/color_selection.dart';

abstract class ColorTransformerType {
  ColorSelection rotate(ColorSelection selection, double change);

  ColorSelection changeLightness(ColorSelection selection, double change);
}
