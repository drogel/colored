import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/search/color_suggestions_search_data.dart';
import 'package:flutter/material.dart';

class ColorSuggestionsSearchNotifier extends StatefulWidget {
  const ColorSuggestionsSearchNotifier({
    required this.child,
    required this.injector,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final BaseNamesInjector<NamedColor> injector;

  @override
  _ColorSuggestionsSearchNotifierState createState() =>
      _ColorSuggestionsSearchNotifierState();
}

class _ColorSuggestionsSearchNotifierState
    extends State<ColorSuggestionsSearchNotifier> {
  late final BaseNamesListViewModel<NamedColor> _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<NamesListState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => ColorSuggestionsSearchData(
          state: snapshot.data ?? _viewModel.initialState,
          onSearchStarted: _viewModel.startSearch,
          onSearchCleared: _viewModel.clearSearch,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
