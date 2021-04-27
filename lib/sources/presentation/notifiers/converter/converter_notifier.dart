import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_view_model.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_data.dart';
import 'package:flutter/material.dart';

class ConverterNotifier extends StatefulWidget {
  const ConverterNotifier({
    required this.injector,
    required this.child,
    Key? key,
  }) : super(key: key);

  final ConverterInjector injector;
  final Widget child;

  @override
  _ConverterNotifierState createState() => _ConverterNotifierState();
}

class _ConverterNotifierState extends State<ConverterNotifier> {
  late final ConverterViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel()..init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _handleTransformerStateChange();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ConverterState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => ConverterData(
          state: snapshot.data ?? _viewModel.initialState,
          clipboardShouldFail: _viewModel.clipboardShouldFail,
          onClipboardRetrieved: _onClipBoardRetrieved,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onClipBoardRetrieved(String string, Format format) {
    final transformerData = TransformerData.of(context)!;
    final onDone = transformerData.onSelectionEnded;
    _viewModel.convertStringToColor(string, format, onDone: onDone);
  }

  void _handleTransformerStateChange() {
    final transformerState = TransformerData.of(context)!.state;
    _viewModel.notifySelectionChanged(transformerState.selection);
  }
}
