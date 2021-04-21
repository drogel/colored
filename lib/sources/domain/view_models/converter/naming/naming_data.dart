import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';
import 'package:flutter/material.dart';

class NamingData extends InheritedWidget {
  const NamingData({
    required this.state,
    required Widget child,
    Key? key,
  })  : assert(child != null),
        assert(state != null),
        super(key: key, child: child);

  final NamingState state;

  static NamingData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: NamingData);

  @override
  bool updateShouldNotify(NamingData oldWidget) => oldWidget.state != state;
}
