import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_data.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/color_suggestions/color_suggestions_view_model.dart';
import 'package:flutter/material.dart';

class ColorSuggestionsNotifier extends StatefulWidget {
  const ColorSuggestionsNotifier({
    @required this.child,
    @required this.injector,
    Key key,
  }) : super(key: key);

  final Widget child;
  final ColorSuggestionsInjector injector;

  @override
  _ColorSuggestionsNotifierState createState() =>
      _ColorSuggestionsNotifierState();
}

class _ColorSuggestionsNotifierState extends State<ColorSuggestionsNotifier> {
  ColorSuggestionsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel()..init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ColorSuggestionsState>(
        initialData: _viewModel.initialData,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => ColorSuggestionsData(
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