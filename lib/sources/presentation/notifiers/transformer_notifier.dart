import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_injector.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_state.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_view_model.dart';
import 'package:flutter/material.dart';

class TransformerNotifier extends StatefulWidget {
  const TransformerNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        assert(child != null),
        super(key: key);

  final TransformerInjector injector;
  final Widget child;

  @override
  _TransformerNotifierState createState() => _TransformerNotifierState();
}

class _TransformerNotifierState extends State<TransformerNotifier> {
  TransformerViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<TransformerState>(
        initialData: _viewModel.initialData,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) {
          final sel = snapshot.data.selection;
          return TransformerData(
            state: snapshot.data,
            onSelectionChanged: _viewModel.notifySelectionChanged,
            onSelectionStarted: _viewModel.notifySelectionStarted,
            onSelectionEnded: _viewModel.notifySelectionEnded,
            onColorSwipedVertical: (dy) => _viewModel.changeLightness(dy, sel),
            onColorSwipedHorizontal: (dx) => _viewModel.rotateColor(dx, sel),
            child: widget.child,
          );
        },
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
