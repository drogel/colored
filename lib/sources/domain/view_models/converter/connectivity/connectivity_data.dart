import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_state.dart';
import 'package:flutter/material.dart';

class ConnectivityData extends InheritedWidget {
  const ConnectivityData({
    required this.state,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final ConnectivityState state;

  static ConnectivityData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: ConnectivityData);

  @override
  bool updateShouldNotify(ConnectivityData oldWidget) =>
      state != oldWidget.state;
}
