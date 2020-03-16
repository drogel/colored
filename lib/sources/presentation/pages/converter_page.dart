import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/converter/converter_injector.dart';
import 'package:colored/sources/domain/view_models/converter/converter_state.dart';
import 'package:colored/sources/domain/view_models/converter/converter_view_model.dart';
import 'package:colored/sources/common/extensions/list_swap.dart';
import 'package:expandable_slider/expandable_slider.dart';
import 'package:flutter/cupertino.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({
    @required ConverterInjector injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        _injector = injector,
        super(key: key);

  final ConverterInjector _injector;
  final Widget child;

  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final ExpandableSliderController _controller = ExpandableSliderController();
  final List<Format> _displayedFormats = List<Format>.from(Format.values);
  ConverterViewModel _viewModel;
  ConverterState _state;

  @override
  void initState() {
    _viewModel = widget._injector.injectViewModel();
    _state = _viewModel.getInitialState();
    _viewModel.stateStream.listen(_updateState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selection = _state.selection;
    return ConverterData(
      state: _state,
      onSelectionChanged: _viewModel.notifySelection,
      clipboardShouldFail: _viewModel.clipboardShouldFail,
      onClipboardRetrieved: _viewModel.convertStringToColor,
      onColorSwipedVertical: (dy) => _viewModel.changeLightness(dy, selection),
      onColorSwipedHorizontal: (dx) => _viewModel.rotateColor(dx, selection),
      onFormatSelection: _updateDisplayedFormats,
      slidersController: _controller,
      displayedFormats: _displayedFormats,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _updateState(ConverterState newState) {
    if (newState is Shrinking) {
      _controller.shrink();
    }
    setState(() => _state = newState);
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
}
