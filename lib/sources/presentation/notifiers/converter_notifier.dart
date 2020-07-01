import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:colored/sources/common/extensions/list_swap.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_state.dart';
import 'package:flutter/material.dart';

class ConverterNotifier extends StatefulWidget {
  const ConverterNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        assert(child != null),
        super(key: key);

  final ConverterInjector injector;
  final Widget child;

  @override
  _ConverterNotifierState createState() => _ConverterNotifierState();
}

class _ConverterNotifierState extends State<ConverterNotifier> {
  final List<Format> _displayedFormats = List<Format>.from(Format.values);
  ConverterViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel()..init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final transformerState = TransformerData.of(context).state;
    _viewModel.notifySelectionChanged(transformerState.selection);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ConverterState>(
        initialData: _viewModel.initialData,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => ConverterData(
          state: snapshot.data,
          clipboardShouldFail: _viewModel.clipboardShouldFail,
          onClipboardRetrieved: _onClipBoardRetrieved,
          onFormatSelection: _updateDisplayedFormats,
          displayedFormats: _displayedFormats,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _updateDisplayedFormats(Format selected, Format previous) {
    final previousIndex = _displayedFormats.indexOf(previous);
    if (_displayedFormats.contains(selected)) {
      final selectedIndex = _displayedFormats.indexOf(selected);
      setState(() => _displayedFormats.swap(selectedIndex, previousIndex));
    } else {
      setState(() => _displayedFormats[previousIndex] = selected);
    }
  }

  void _onClipBoardRetrieved(String string, Format format) {
    final transformerData = TransformerData.of(context);
    final onDone = transformerData.onSelectionEnd;
    _viewModel.convertStringToColor(string, format, onDone: onDone);
  }
}
