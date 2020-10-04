import 'package:colored/sources/domain/view_models/converter/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsv/hsv_picker.dart';
import 'package:flutter/material.dart';

class HsvTransformer extends StatelessWidget {
  const HsvTransformer({@required this.saturationValueConstraints, Key key})
      : super(key: key);

  final BoxConstraints saturationValueConstraints;

  @override
  Widget build(BuildContext context) {
    final data = TransformerData.of(context);
    return HsvPicker(
      color: data.state.selection.toColor(),
      onChangeEnd: data.onSelectionEnded,
      onChanged: data.onSelectionChanged,
      onChangeStart: data.onSelectionStarted,
      saturationValuePickerConstraints: saturationValueConstraints,
    );
  }
}
