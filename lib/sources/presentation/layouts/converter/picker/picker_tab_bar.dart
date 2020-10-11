import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_data.dart';
import 'package:colored/sources/presentation/layouts/converter/picker/picker_tab.dart';
import 'package:flutter/material.dart';

class PickerTabBar extends StatelessWidget implements PreferredSizeWidget {
  const PickerTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = PickerData.of(context);
    final selectedPicker = data.state.pickerStyle;
    final selectedPickerIndex = PickerStyle.values.indexOf(selectedPicker);
    return DefaultTabController(
      initialIndex: selectedPickerIndex,
      length: PickerStyle.values.length,
      child: TabBar(
        tabs: PickerStyle.values.map((p) => PickerTab(style: p)).toList(),
        onTap: data.onPickerSelected,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
