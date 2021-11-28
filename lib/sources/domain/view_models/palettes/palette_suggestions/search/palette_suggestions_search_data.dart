import 'package:colored/sources/domain/view_models/base/names/base_names_data.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsSearchData extends BaseNamesData {
  const PaletteSuggestionsSearchData({
    required NamesListState state,
    required Future<void> Function(String) onSearchStarted,
    required void Function() onSearchCleared,
    required Widget child,
    Key? key,
  }) : super(
          key: key,
          state: state,
          onSearchStarted: onSearchStarted,
          onSearchCleared: onSearchCleared,
          child: child,
        );

  static PaletteSuggestionsSearchData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(
        aspect: PaletteSuggestionsSearchData,
      );
}
