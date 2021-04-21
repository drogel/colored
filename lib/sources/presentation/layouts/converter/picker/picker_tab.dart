import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:flutter/material.dart';

class PickerTab extends StatelessWidget {
  const PickerTab({required this.style, Key? key}) : super(key: key);

  final PickerStyle style;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(style),
          SizedBox(width: padding.medium.left),
          Text(style.rawValue!)
        ],
      ),
    );
  }

  Icon _buildIcon(PickerStyle pickerStyle) {
    switch (pickerStyle) {
      case PickerStyle.hsl:
        return const Icon(Icons.blur_linear);
      case PickerStyle.hsv:
        return const Icon(Icons.gradient);
      default:
        return const Icon(Icons.tune);
    }
  }
}
