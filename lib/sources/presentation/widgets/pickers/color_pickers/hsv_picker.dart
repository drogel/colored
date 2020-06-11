import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/pickers/color_pickers/color_picker_layout.dart';
import 'package:colored/sources/presentation/widgets/pickers/color_pickers/hsv_track.dart';
import 'package:colored/sources/presentation/widgets/pickers/color_pickers/surface_color_picker.dart';
import 'package:flutter/material.dart';

class HsvPicker extends StatelessWidget {
  const HsvPicker({
    @required this.color,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.purifier = const DefaultColorPurifier(),
    this.height = 80,
    Key key,
  })  : assert(color != null),
        super(key: key);

  final double height;
  final Color color;
  final ColorPurifier purifier;
  final void Function(ColorSelection) onChanged;
  final void Function(ColorSelection) onChangeStart;
  final void Function(ColorSelection) onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final hue = purifier.getHue(color);
    return ColorPickerLayout(
      height: height,
      child: SurfaceColorPicker(
        value: _pickerValue(),
        color: color,
        track: HsvTrack(hue: hue),
        onChanged: (x, y) => _notify(_select(hue, x, y), onChanged),
        onChangeStart: (x, y) => _notify(_select(hue, x, y), onChangeStart),
        onChangeEnd: (x, y) => _notify(_select(hue, x, y), onChangeEnd),
      ),
    );
  }

  ColorSelection _select(double hue, double dx, double dy) =>
      ColorSelection.fromHSV(h: hue, s: dx, v: _reverseValue(dy));

  double _reverseValue(double dy) => 1 - dy;

  Offset _pickerValue() {
    final hsvColor = HSVColor.fromColor(color);
    return Offset(hsvColor.saturation, _reverseValue(hsvColor.value));
  }

  void _notify(
    ColorSelection selection,
    void Function(ColorSelection) notifier,
  ) {
    if (notifier != null) {
      notifier(selection);
    }
  }
}
