import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:flutter/material.dart';

class NamingData extends InheritedWidget {
  const NamingData({
    @required this.state,
    @required this.onSelectionStart,
    @required this.onSelectionEnd,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(state != null),
        assert(onSelectionEnd != null),
        assert(onSelectionStart != null),
        super(key: key, child: child);

  final NamingState state;
  final void Function(ColorSelection) onSelectionStart;
  final void Function(ColorSelection) onSelectionEnd;

  static NamingData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamingData);

  @override
  bool updateShouldNotify(NamingData oldWidget) => oldWidget.state != state;
}
