import 'dart:math';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/color_transformer/color_transformer_type.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:vector_math/vector_math.dart';

class ColorTransformer implements ColorTransformerType {
  const ColorTransformer();

  @override
  ColorSelection changeLightness(ColorSelection selection, double change) {
    final red = (selection.first * decimal8Bit + change)
        .round()
        .clamp(0, decimal8Bit);
    final green = (selection.second * decimal8Bit + change)
        .round()
        .clamp(0, decimal8Bit);
    final blue = (selection.third * decimal8Bit + change)
        .round()
        .clamp(0, decimal8Bit);
    final changedSelection = ColorSelection(
      first: red / decimal8Bit,
      second: green / decimal8Bit,
      third: blue / decimal8Bit,
    );
    return changedSelection;
  }

  @override
  ColorSelection rotate(ColorSelection selection, double change) {
    final m = Matrix3.identity();
    final cosA = cos(radians(change));
    final sinA = sin(radians(change));
    final arg0 = cosA + (1 - cosA) / 3;
    final arg1 = 1 / 3 * (1 - cosA) - sqrt(1 / 3) * sinA;
    final arg2 = 1 / 3 * (1 - cosA) + sqrt(1 / 3) * sinA;
    final arg3 = 1 / 3 * (1 - cosA) + sqrt(1 / 3) * sinA;
    final arg4 = cosA + 1 / 3 * (1 - cosA);
    final arg5 = 1 / 3 * (1 - cosA) - sqrt(1 / 3) * sinA;
    final arg6 = 1 / 3 * (1 - cosA) - sqrt(1 / 3) * sinA;
    final arg7 = 1 / 3 * (1 - cosA) + sqrt(1 / 3) * sinA;
    final arg8 = cosA + 1 / 3 * (1 - cosA);
    m.setValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);

    final r = decimal8Bit * selection.first;
    final g = decimal8Bit * selection.second;
    final b = decimal8Bit * selection.third;
    final rx = r * m.entry(0, 0) + g * m.entry(0, 1) + b * m.entry(0, 2);
    final gx = r * m.entry(1, 0) + g * m.entry(1, 1) + b * m.entry(1, 2);
    final bx = r * m.entry(2, 0) + g * m.entry(2, 1) + b * m.entry(2, 2);

    final rotatedSelection = ColorSelection(
      first: rx.clamp(0, decimal8Bit) / decimal8Bit,
      second: gx.clamp(0, decimal8Bit) / decimal8Bit,
      third: bx.clamp(0, decimal8Bit) / decimal8Bit,
    );
    return rotatedSelection;
  }
}