import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_data.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_injector.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_state.dart';
import 'package:colored/sources/domain/view_models/displayed_formats/displayed_formats_view_model.dart';
import 'package:flutter/material.dart';

class DisplayedFormatsNotifier extends StatefulWidget {
  const DisplayedFormatsNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  }) : super(key: key);

  final DisplayedFormatsInjector injector;
  final Widget child;

  @override
  _DisplayedFormatsNotifierState createState() =>
      _DisplayedFormatsNotifierState();
}

class _DisplayedFormatsNotifierState extends State<DisplayedFormatsNotifier> {
  DisplayedFormatsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<DisplayedFormatsState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (_, snapshot) => DisplayedFormatsData(
          state: snapshot.data,
          onFormatSelection: _viewModel.updateDisplayedFormats,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
