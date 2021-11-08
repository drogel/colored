import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:flutter/material.dart';

class NamesListData extends InheritedWidget {
  const NamesListData({
    required this.state,
    required this.onSearchChanged,
    required this.onSearchStarted,
    required this.onSearchCleared,
    required this.onBackPressed,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final NamesListState state;
  final PaginatedNamesSearcher<NamedColor> onSearchChanged;
  final Future<void> Function(String) onSearchStarted;
  final void Function() onSearchCleared;
  final void Function() onBackPressed;

  static NamesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamesListData);

  @override
  bool updateShouldNotify(NamesListData oldWidget) => oldWidget.state != state;
}
