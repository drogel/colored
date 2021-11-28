import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/base/names/paginated_names_data.dart';
import 'package:flutter/material.dart';

class PalettesListData extends PaginatedNamesData<Palette> {
  const PalettesListData({
    required NamesListState state,
    required PaginatedNamesSearcher<Palette> onPageFinished,
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

  static PalettesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: PalettesListData);
}
