import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:flutter/material.dart';

class BaseNamesData extends InheritedWidget {
  const BaseNamesData({
    required this.state,
    required this.onSearchStarted,
    required this.onSearchCleared,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final NamesListState state;
  final Future<void> Function(String) onSearchStarted;
  final void Function() onSearchCleared;

  @override
  bool updateShouldNotify(BaseNamesData oldWidget) => oldWidget.state != state;
}
