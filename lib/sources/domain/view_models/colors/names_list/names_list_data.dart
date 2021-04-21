import 'package:flutter/material.dart';

import 'names_list_state.dart';

class NamesListData extends InheritedWidget {
  const NamesListData({
    required this.state,
    required this.onSearchChanged,
    required this.onBackPressed,
    required Widget child,
    Key? key,
  })  : assert(child != null),
        assert(onSearchChanged != null),
        super(key: key, child: child);

  final NamesListState? state;
  final void Function(String) onSearchChanged;
  final void Function() onBackPressed;

  static NamesListData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamesListData);

  @override
  bool updateShouldNotify(NamesListData oldWidget) => oldWidget.state != state;
}
