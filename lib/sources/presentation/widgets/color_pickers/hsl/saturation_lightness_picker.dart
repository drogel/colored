import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsl/saturation_lightness_track.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_selector.dart';
import 'package:flutter/material.dart';

class SaturationLightnessPicker extends StatelessWidget {
  const SaturationLightnessPicker({
    required this.color,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.purifier = const DefaultColorPurifier(),
    this.constraints,
    Key? key,
  })  : assert(color != null),
        super(key: key);

  final BoxConstraints? constraints;
  final Color color;
  final ColorPurifier purifier;
  final void Function(ColorSelection)? onChanged;
  final void Function(ColorSelection)? onChangeStart;
  final void Function(ColorSelection)? onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final currentHue = purifier.getHue(color);
    return HueBasedPicker(
      color: color,
      selector: _HslPickerSelector(color: color, purifier: purifier),
      constraints: constraints ?? const BoxConstraints(maxHeight: 100),
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      onChanged: onChanged,
      track: SaturationLightnessTrack(hue: currentHue),
    );
  }
}

class _HslPickerSelector implements HueBasedSelector {
  const _HslPickerSelector({required this.color, required this.purifier});

  final Color color;
  final ColorPurifier purifier;

  @override
  Offset pickValue() {
    final hslColor = HSLColor.fromColor(color);
    return Offset(hslColor.saturation, _reverseValue(hslColor.lightness));
  }

  @override
  ColorSelection select(double dx, double dy) {
    final currentHue = purifier.getHue(color);
    return ColorSelection.fromHSL(h: currentHue, s: dx, l: _reverseValue(dy));
  }

  double _reverseValue(double dy) => 1 - dy;
}
