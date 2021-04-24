import 'package:colored/sources/domain/view_models/converter/naming/naming_data.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_injector.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_view_model.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:flutter/material.dart';

class NamingNotifier extends StatefulWidget {
  const NamingNotifier({
    required NamingInjector injector,
    required this.child,
    Key? key,
  })  : _injector = injector,
        super(key: key);

  final NamingInjector _injector;
  final Widget child;

  @override
  _NamingNotifierState createState() => _NamingNotifierState();
}

class _NamingNotifierState extends State<NamingNotifier> {
  late NamingViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget._injector.injectViewModel();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _handleTransformerStateChange();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<NamingState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => NamingData(
          state: snapshot.data ?? _viewModel.initialState,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _handleTransformerStateChange() {
    final state = TransformerData.of(context)!.state;
    if (state is SelectionEnded) {
      _viewModel.fetchNaming(state.selection);
    }
  }
}
