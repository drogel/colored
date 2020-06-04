import 'package:colored/sources/domain/view_models/connectivity/connectivity_data.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_injector.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_state.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_view_model.dart';
import 'package:flutter/material.dart';

class ConnectivityNotifier extends StatefulWidget {
  const ConnectivityNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(child != null),
        assert(injector != null),
        super(key: key);

  final ConnectivityInjector injector;
  final Widget child;

  @override
  _ConnectivityNotifierState createState() => _ConnectivityNotifierState();
}

class _ConnectivityNotifierState extends State<ConnectivityNotifier> {
  ConnectivityViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel()..init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ConnectivityState>(
        stream: _viewModel.stateStream,
        initialData: _viewModel.initialData,
        builder: (context, snapshot) => ConnectivityData(
          state: snapshot.data,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
