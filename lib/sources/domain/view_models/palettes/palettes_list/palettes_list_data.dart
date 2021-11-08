import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:flutter/material.dart';

class PalettesListData extends InheritedWidget {
  const PalettesListData({
    required this.state,
    required this.onSearchChanged,
    required this.onSearchStarted,
    required this.onSearchCleared,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final NamesListState state;
  final PaginatedNamesSearcher<Palette> onSearchChanged;
  final Future<void> Function(String) onSearchStarted;
  final void Function() onSearchCleared;

  static PalettesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PalettesListData);

  @override
  bool updateShouldNotify(PalettesListData oldWidget) =>
      state != oldWidget.state;
}
