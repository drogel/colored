import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';
import 'package:flutter/material.dart';

class PalettesListData extends InheritedWidget {
  const PalettesListData({
    required this.state,
    required this.onSearchChanged,
    required Widget child,
    Key? key,
  })  : assert(child != null),
        assert(state != null),
        super(key: key, child: child);

  static PalettesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PalettesListData);

  final PalettesListState state;
  final void Function(String) onSearchChanged;

  @override
  bool updateShouldNotify(PalettesListData oldWidget) =>
      state != oldWidget.state;
}
