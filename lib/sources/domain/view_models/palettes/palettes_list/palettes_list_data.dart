import 'package:colored/sources/domain/view_models/base/names/names_list_state.dart';
import 'package:flutter/material.dart';

class PalettesListData extends InheritedWidget {
  const PalettesListData({
    required this.state,
    required this.onSearchChanged,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final NamesListState state;
  final void Function(String) onSearchChanged;

  static PalettesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PalettesListData);

  @override
  bool updateShouldNotify(PalettesListData oldWidget) =>
      state != oldWidget.state;
}
