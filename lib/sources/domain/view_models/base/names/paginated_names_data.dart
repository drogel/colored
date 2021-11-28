import 'package:colored/sources/domain/view_models/base/names/base_names_data.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:flutter/material.dart';

class PaginatedNamesData<T> extends BaseNamesData {
  const PaginatedNamesData({
    required NamesListState state,
    required this.onPageFinished,
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

  final PaginatedNamesSearcher<T> onPageFinished;
}
