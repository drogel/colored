import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
import 'package:flutter/material.dart';

typedef PaginatedNamesSearcher = Future<void> Function(
  String, {
  required PageInfo pageInfo,
});

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
  final PaginatedNamesSearcher onSearchChanged;
  final Future<void> Function(String) onSearchStarted;
  final void Function() onSearchCleared;
  final void Function() onBackPressed;

  static NamesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamesListData);

  @override
  bool updateShouldNotify(NamesListData oldWidget) => oldWidget.state != state;
}
