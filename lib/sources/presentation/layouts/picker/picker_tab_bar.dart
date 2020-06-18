import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/picker/picker_data.dart';
import 'package:flutter/material.dart';

class PickerTabBar extends StatelessWidget implements PreferredSizeWidget {
  const PickerTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = PickerData.of(context);
    final padding = PaddingData.of(context).paddingScheme;
    return DefaultTabController(
      length: PickerStyle.values.length,
      child: TabBar(
        tabs: PickerStyle.values
            .map((style) => _buildTab(style, padding.medium.left))
            .toList(),
        onTap: data.onPickerSelected,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

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

  Widget _buildTab(PickerStyle pickerStyle, double spacing) => Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(pickerStyle),
            SizedBox(width: spacing),
            Text(pickerStyle.rawValue)
          ],
        ),
      );
}
