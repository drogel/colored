import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsv/saturation_value_track.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/base/hue_base/hue_based_selector.dart';
import 'package:flutter/material.dart';

class SaturationValuePicker extends StatelessWidget {
  const SaturationValuePicker({
    @required this.color,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.purifier = const DefaultColorPurifier(),
    this.constraints,
    Key key,
  })  : assert(color != null),
        super(key: key);

  final BoxConstraints constraints;
  final Color color;
  final ColorPurifier purifier;
  final void Function(ColorSelection) onChanged;
  final void Function(ColorSelection) onChangeStart;
  final void Function(ColorSelection) onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final currentHue = purifier.getHue(color);
    return HueBasedPicker(
      color: color,
      selector: _HsvPickerSelector(color: color, purifier: purifier),
      constraints: constraints ?? const BoxConstraints(maxHeight: 100),
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      onChanged: onChanged,
      track: SaturationValueTrack(hue: currentHue),
    );
  }
}

class _HsvPickerSelector implements HueBasedSelector {
  const _HsvPickerSelector({@required this.color, @required this.purifier});

  final Color color;
  final ColorPurifier purifier;

  @override
  Offset pickValue() {
    final hsvColor = HSVColor.fromColor(color);
    return Offset(hsvColor.saturation, _reverseValue(hsvColor.value));
  }

  @override
  ColorSelection select(double dx, double dy) {
    final currentHue = purifier.getHue(color);
    return ColorSelection.fromHSV(h: currentHue, s: dx, v: _reverseValue(dy));
  }

  double _reverseValue(double dy) => 1 - dy;
}
