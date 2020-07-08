import 'dart:ui';

import 'package:colored/sources/domain/data_models/color_selection.dart';

abstract class HueBasedSelector {
  ColorSelection select(double dx, double dy);

  Offset pickValue();
}
