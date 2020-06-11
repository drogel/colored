import 'package:colored/sources/common/factors.dart' as factors;
import 'package:colored/sources/data/color_helpers/color_purifier/color_purifier.dart';
import 'package:colored/sources/data/color_helpers/color_purifier/default_color_purifier.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/pickers/color_pickers/color_picker_layout.dart';
import 'package:colored/sources/presentation/widgets/pickers/color_pickers/hue_track.dart';
import 'package:colored/sources/presentation/widgets/pickers/color_pickers/surface_color_picker.dart';
import 'package:flutter/material.dart';

class HuePicker extends StatelessWidget {
  const HuePicker({
    @required this.color,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.height = 8,
    this.purifier = const DefaultColorPurifier(),
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
    final pureColor = purifier.purify(color);
    return ColorPickerLayout(
      height: height,
      child: SurfaceColorPicker(
        value: _pickerValue(pureColor),
        color: pureColor,
        track: const HueTrack(),
        onChanged: (x, y) => _notify(_select(x), onChanged),
        onChangeStart: (x, y) => _notify(_select(x), onChangeStart),
        onChangeEnd: (x, y) => _notify(_select(x), onChangeEnd),
      ),
    );
  }

  ColorSelection _select(double dx) =>
      ColorSelection.fromHSV(h: dx * factors.degreesInTurn, s: 1, v: 1);

  Offset _pickerValue(Color color) {
    final hsvColor = HSVColor.fromColor(color);
    final x = hsvColor.hue.roundToDouble() / factors.degreesInTurn;
    return Offset(x, 0.5);
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
