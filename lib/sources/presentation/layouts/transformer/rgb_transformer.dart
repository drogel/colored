import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_state.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/rgb/rgb_picker.dart';
import 'package:flutter/material.dart';

class RgbTransformer extends StatelessWidget {
  const RgbTransformer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = TransformerData.of(context);
    return RgbPicker(
      selection: data.state.selection,
      onChanged: data.onSelectionChanged,
      onChangeEnd: data.onSelectionEnded,
      shouldShrink: data.state is SelectionStarted,
    );
  }
}