import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsl/saturation_lightness_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hue/hue_picker.dart';
import 'package:flutter/material.dart';

class HslPicker extends StatelessWidget {
  const HslPicker({
    @required this.color,
    @required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    Key key,
  }) : super(key: key);

  final Color color;
  final void Function(ColorSelection) onChanged;
  final void Function(ColorSelection) onChangeStart;
  final void Function(ColorSelection) onChangeEnd;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HuePicker(
            color: color,
            onChangeEnd: onChangeEnd,
            onChanged: onChanged,
            onChangeStart: onChangeStart,
          ),
          SaturationLightnessPicker(
            color: color,
            onChangeEnd: onChangeEnd,
            onChanged: onChanged,
            onChangeStart: onChangeStart,
          )
        ],
      );
}
