import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_data.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_injector.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter/material.dart';

class IndexedNavigationNotifier extends StatefulWidget {
  const IndexedNavigationNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        assert(child != null),
        super(key: key);

  final IndexedNavigationInjector injector;
  final Widget child;

  @override
  _IndexedNavigationNotifierState createState() =>
      _IndexedNavigationNotifierState();
}

class _IndexedNavigationNotifierState extends State<IndexedNavigationNotifier> {
  IndexedNavigationController _controller;

  @override
  void initState() {
    _controller = widget.injector.injectController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IndexedNavigationState>(
        initialData: _controller.initialState,
        stream: _controller.stateStream,
        builder: (context, snapshot) => IndexedNavigationData(
          state: snapshot.data,
          onNavigation: _controller.navigateToIndex,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
