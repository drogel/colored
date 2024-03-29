import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/base/names/paginated_names_data.dart';
import 'package:flutter/material.dart';

class NamesListData extends PaginatedNamesData<NamedColor> {
  const NamesListData({
    required this.onBackPressed,
    required NamesListState state,
    required PaginatedNamesSearcher<NamedColor> onPageFinished,
    required Future<void> Function(String) onSearchStarted,
    required void Function() onSearchCleared,
    required Widget child,
    Key? key,
  }) : super(
          key: key,
          state: state,
          onPageFinished: onPageFinished,
          onSearchStarted: onSearchStarted,
          onSearchCleared: onSearchCleared,
          child: child,
        );

  final void Function() onBackPressed;

  static NamesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamesListData);
}
