import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsl/hsl_picker.dart';
import 'package:flutter/material.dart';

class HslTransformer extends StatelessWidget {
  const HslTransformer({@required this.saturationLightnessConstraints, Key key})
      : super(key: key);

  final BoxConstraints saturationLightnessConstraints;

  @override
  Widget build(BuildContext context) {
    final data = TransformerData.of(context);
    return HslPicker(
      color: data.state.selection.toColor(),
      onChangeEnd: data.onSelectionEnded,
      onChanged: data.onSelectionChanged,
      onChangeStart: data.onSelectionStarted,
      saturationLightnessPickerConstraints: saturationLightnessConstraints,
    );
  }
}
