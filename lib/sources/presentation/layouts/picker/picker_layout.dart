import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/picker/picker_data.dart';
import 'package:colored/sources/presentation/layouts/transformer/hsl_transformer.dart';
import 'package:colored/sources/presentation/layouts/transformer/hsv_transformer.dart';
import 'package:colored/sources/presentation/layouts/transformer/rgb_transformer.dart';
import 'package:colored/sources/presentation/widgets/animations/default_animated_switcher.dart';
import 'package:flutter/material.dart';

const _kSaturationPickersMaxConstraints = BoxConstraints(maxHeight: 200);
const _kSaturationPickersMinConstraints = BoxConstraints(maxHeight: 100);

class PickerLayout extends StatelessWidget {
  const PickerLayout({
    @required this.availableHeight,
    Key key,
  }) : super(key: key);

  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    final data = PickerData.of(context);
    return DefaultAnimatedSwitcher(child: _buildPicker(data));
  }

  Widget _buildPicker(PickerData data) {
    if (data == null) {
      return const RgbTransformer();
    }

    final constraints = _getLayoutConstraints();
    switch (data.state.pickerStyle) {
      case PickerStyle.hsl:
        return HslTransformer(saturationLightnessConstraints: constraints);
      case PickerStyle.hsv:
        return HsvTransformer(saturationValueConstraints: constraints);
      default:
        return const RgbTransformer();
    }
  }

  BoxConstraints _getLayoutConstraints() =>
      availableHeight / 2 > _kSaturationPickersMaxConstraints.maxHeight
          ? _kSaturationPickersMaxConstraints
          : _kSaturationPickersMinConstraints;
}
