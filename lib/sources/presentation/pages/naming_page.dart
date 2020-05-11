import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/naming/naming_data.dart';
import 'package:colored/sources/domain/view_models/naming/naming_injector.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/naming/naming_view_model.dart';
import 'package:flutter/material.dart';

class NamingPage extends StatefulWidget {
  const NamingPage({
    @required NamingInjector injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        _injector = injector,
        super(key: key);

  final NamingInjector _injector;
  final Widget child;

  @override
  _NamingPageState createState() => _NamingPageState();
}

class _NamingPageState extends State<NamingPage> {
  NamingViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget._injector.injectViewModel();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final state = ConverterData.of(context).state;
    _handleConverterStateChange(state);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<NamingState>(
        initialData: _viewModel.initialData,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => NamingData(
          state: snapshot.data,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _handleConverterStateChange(ConverterState state) {
    print(state.runtimeType);
    switch (state.runtimeType) {
      case SelectionStarted:
        _viewModel.notifyNamingChange(state.selection);
        break;
      case SelectionEnded:
        _viewModel.fetchNaming(state.selection);
        break;
    }
  }
}
