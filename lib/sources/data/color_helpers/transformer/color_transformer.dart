import 'dart:math';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/transformer/transformer.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:vector_math/vector_math.dart';

class ColorTransformer implements Transformer {
  const ColorTransformer();

  @override
  ColorSelection changeLightness(ColorSelection selection, double change) {
    final num red = (selection.r * decimal8Bit + change)
        .round()
        .clamp(0, decimal8Bit);
    final num green = (selection.g * decimal8Bit + change)
        .round()
        .clamp(0, decimal8Bit);
    final num blue = (selection.b * decimal8Bit + change)
        .round()
        .clamp(0, decimal8Bit);
    final changedSelection = ColorSelection(
      r: red / decimal8Bit,
      g: green / decimal8Bit,
      b: blue / decimal8Bit,
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

    final r = decimal8Bit * selection.r;
    final g = decimal8Bit * selection.g;
    final b = decimal8Bit * selection.b;
    final rx = r * m.entry(0, 0) + g * m.entry(0, 1) + b * m.entry(0, 2);
    final gx = r * m.entry(1, 0) + g * m.entry(1, 1) + b * m.entry(1, 2);
    final bx = r * m.entry(2, 0) + g * m.entry(2, 1) + b * m.entry(2, 2);

    final rotatedSelection = ColorSelection(
      r: rx.clamp(0, decimal8Bit) / decimal8Bit,
      g: gx.clamp(0, decimal8Bit) / decimal8Bit,
      b: bx.clamp(0, decimal8Bit) / decimal8Bit,
    );
    return rotatedSelection;
  }
}