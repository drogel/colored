import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsl/hsl_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/hsv/hsv_picker.dart';
import 'package:colored/sources/presentation/widgets/color_pickers/rgb/rgb_picker.dart';
import 'package:flutter/material.dart';

class ConverterPicker extends StatelessWidget {
  const ConverterPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    final duration = DurationData.of(context).durationScheme;
    final curves = CurveData.of(context).curveScheme;
    return AnimatedSwitcher(
      switchInCurve: curves.incoming,
      duration: duration.mediumPresenting,
      reverseDuration: duration.mediumDismissing,
      child: _buildPicker(data),
    );
  }

  Widget _buildPicker(ConverterData data) {
    switch (data.pickerStyle) {
      case PickerStyle.hsl:
        return HslPicker(
          color: data.state.color,
          onChangeEnd: data.onSelectionEnd,
          onChanged: data.onSelectionChanged,
          onChangeStart: data.onSelectionStarted,
        );
      case PickerStyle.hsv:
        return HsvPicker(
          color: data.state.color,
          onChangeEnd: data.onSelectionEnd,
          onChanged: data.onSelectionChanged,
          onChangeStart: data.onSelectionStarted,
        );
      default:
        return RgbPicker(
          selection: data.state.selection,
          onChanged: data.onSelectionChanged,
          onChangeEnd: data.onSelectionEnd,
          step: data.state.converterStep,
        );
    }
  }
}
