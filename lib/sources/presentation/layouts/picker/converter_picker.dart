import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/picker/picker_data.dart';
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
    final converterData = ConverterData.of(context);
    final data = PickerData.of(context);
    final duration = DurationData.of(context).durationScheme;
    final curves = CurveData.of(context).curveScheme;
    return AnimatedSwitcher(
      switchInCurve: curves.incoming,
      duration: duration.mediumPresenting,
      reverseDuration: duration.mediumDismissing,
      child: _buildPicker(data, converterData),
    );
  }

  Widget _buildPicker(PickerData data, ConverterData converterData) {
    if (data == null) {
      return _buildDefaultPicker(converterData);
    }

    switch (data.state.pickerStyle) {
      case PickerStyle.hsl:
        return _buildHslPicker(converterData);
      case PickerStyle.hsv:
        return _buildHsvPicker(converterData);
      default:
        return _buildDefaultPicker(converterData);
    }
  }

  Widget _buildDefaultPicker(ConverterData converterData) => RgbPicker(
        selection: converterData.state.selection,
        onChanged: converterData.onSelectionChanged,
        onChangeEnd: converterData.onSelectionEnd,
      );

  Widget _buildHslPicker(ConverterData converterData) => HslPicker(
        color: converterData.state.selection.toColor(),
        onChangeEnd: converterData.onSelectionEnd,
        onChanged: converterData.onSelectionChanged,
        onChangeStart: converterData.onSelectionStarted,
        saturationLightnessPickerConstraints: _getLayoutConstraints(),
      );

  Widget _buildHsvPicker(ConverterData converterData) => HsvPicker(
        color: converterData.state.selection.toColor(),
        onChangeEnd: converterData.onSelectionEnd,
        onChanged: converterData.onSelectionChanged,
        onChangeStart: converterData.onSelectionStarted,
        saturationValuePickerConstraints: _getLayoutConstraints(),
      );

  BoxConstraints _getLayoutConstraints() =>
      availableHeight / 2 > _kSaturationPickersMaxConstraints.maxHeight
          ? _kSaturationPickersMaxConstraints
          : _kSaturationPickersMinConstraints;
}
