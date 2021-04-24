import 'package:colored/sources/common/factors.dart' as factors;
import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_selector.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hue/hue_track.dart';
import 'package:flutter/material.dart';

class HuePicker extends StatelessWidget {
  const HuePicker({
    required this.color,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.constraints = const BoxConstraints(maxHeight: 44),
    this.purifier = const DefaultColorPurifier(),
    Key? key,
  }) : super(key: key);

  final BoxConstraints constraints;
  final Color color;
  final ColorPurifier purifier;
  final void Function(ColorSelection)? onChanged;
  final void Function(ColorSelection)? onChangeStart;
  final void Function(ColorSelection)? onChangeEnd;

  @override
  Widget build(BuildContext context) => HueBasedPicker(
        color: purifier.purify(color),
        selector: _HuePickerSelector(color: color, purifier: purifier),
        constraints: constraints,
        onChanged: onChanged,
        onChangeEnd: onChangeEnd,
        onChangeStart: onChangeStart,
        track: const HueTrack(),
      );
}

class _HuePickerSelector implements HueBasedSelector {
  const _HuePickerSelector({required this.color, required this.purifier});

  final Color color;
  final ColorPurifier purifier;

  @override
  Offset pickValue() {
    final hue = purifier.getHue(color);
    final x = hue / (factors.degreesInTurn);
    return Offset(x, 0.5);
  }

  @override
  ColorSelection select(double dx, double dy) {
    final currentHsvColor = HSVColor.fromColor(color);
    final newHue = dx * factors.degreesInTurn;
    final clampedHue = newHue.clamp(0, factors.degreesInTurn - 1).toDouble();
    final currentSat = currentHsvColor.saturation;
    final currentVal = currentHsvColor.value;
    return ColorSelection.fromHSV(h: clampedHue, s: currentSat, v: currentVal);
  }
}
