import 'package:colored/sources/domain/inherited/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:flutter/cupertino.dart';

class ConverterUpdater extends StatefulWidget {
  const ConverterUpdater({
    @required ConverterViewModel viewModel,
    @required this.child,
    Key key,
  })  : assert(viewModel != null),
        _viewModel = viewModel,
        super(key: key);

  final ConverterViewModel _viewModel;
  final Widget child;

  @override
  _ConverterUpdaterState createState() => _ConverterUpdaterState();
}

class _ConverterUpdaterState extends State<ConverterUpdater> {
  ConverterViewModel _viewModel;
  ConverterState _state;

  @override
  void initState() {
    _viewModel = widget._viewModel;
    _state = _viewModel.getInitialState();
    _viewModel.stateStream.listen(_updateState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ConverterData(
        state: _state,
        onSelectionChanged: _viewModel.convertToColor,
        child: widget.child,
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _updateState(ConverterState newState) =>
      setState(() => _state = newState);
}
