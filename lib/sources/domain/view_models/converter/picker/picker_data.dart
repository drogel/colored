import 'package:colored/sources/domain/view_models/converter/picker/picker_state.dart';
import 'package:flutter/material.dart';

class PickerData extends InheritedWidget {
  const PickerData({
    @required this.state,
    @required Widget child,
    this.onPickerSelected,
    Key key,
  })  : assert(child != null),
        assert(state != null),
        super(key: key, child: child);

  final PickerState state;
  final void Function(int) onPickerSelected;

  static PickerData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PickerData);

  @override
  bool updateShouldNotify(PickerData oldWidget) => oldWidget.state != state;
}
