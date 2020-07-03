import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/picker/picker_data.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_state.dart';
import 'package:colored/sources/presentation/widgets/animations/default_animated_switcher.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsl/hsl_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsv/hsv_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/rgb/rgb_picker.dart';
import 'package:flutter/material.dart';

const _kSaturationPickersMaxConstraints = BoxConstraints(maxHeight: 200);
const _kSaturationPickersMinConstraints = BoxConstraints(maxHeight: 100);

class ConverterPicker extends StatelessWidget {
  const ConverterPicker({
    @required this.availableHeight,
    Key key,
  }) : super(key: key);

  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    final data = PickerData.of(context);
    final transformerData = TransformerData.of(context);
    return DefaultAnimatedSwitcher(
      child: _buildPicker(
        data: data,
        transformerData: transformerData,
      ),
    );
  }

  Widget _buildPicker({
    @required PickerData data,
    @required TransformerData transformerData,
  }) {
    if (data == null) {
      return _buildDefaultPicker(transformerData);
    }

    switch (data.state.pickerStyle) {
      case PickerStyle.hsl:
        return _buildHslPicker(transformerData);
      case PickerStyle.hsv:
        return _buildHsvPicker(transformerData);
      default:
        return _buildDefaultPicker(transformerData);
    }
  }

  Widget _buildDefaultPicker(
    TransformerData transformerData,
  ) =>
      RgbPicker(
        selection: transformerData.state.selection,
        onChanged: transformerData.onSelectionChanged,
        onChangeEnd: transformerData.onSelectionEnded,
        shouldShrink: transformerData.state is SelectionStarted,
      );

  Widget _buildHslPicker(
    TransformerData transformerData,
  ) =>
      HslPicker(
        color: transformerData.state.selection.toColor(),
        onChangeEnd: transformerData.onSelectionEnded,
        onChanged: transformerData.onSelectionChanged,
        onChangeStart: transformerData.onSelectionStarted,
        saturationLightnessPickerConstraints: _getLayoutConstraints(),
      );

  Widget _buildHsvPicker(
    TransformerData transformerData,
  ) =>
      HsvPicker(
        color: transformerData.state.selection.toColor(),
        onChangeEnd: transformerData.onSelectionEnded,
        onChanged: transformerData.onSelectionChanged,
        onChangeStart: transformerData.onSelectionStarted,
        saturationValuePickerConstraints: _getLayoutConstraints(),
      );

  BoxConstraints _getLayoutConstraints() =>
      availableHeight / 2 > _kSaturationPickersMaxConstraints.maxHeight
          ? _kSaturationPickersMaxConstraints
          : _kSaturationPickersMinConstraints;
}
