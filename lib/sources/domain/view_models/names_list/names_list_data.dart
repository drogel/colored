import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:flutter/material.dart';

class NamesListData extends InheritedWidget {
  const NamesListData({
    @required this.state,
    @required this.onSearchChanged,
    @required Widget child,
    Key key,
  })  : assert(child != null),
        assert(onSearchChanged != null),
        super(key: key, child: child);

  final NamesListState state;
  final void Function(String) onSearchChanged;

  static NamesListData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamesListData);

  @override
  bool updateShouldNotify(NamesListData oldWidget) => oldWidget.state != state;
}
