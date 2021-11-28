import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/search/palette_suggestions_search_data.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsSearchNotifier extends StatefulWidget {
  const PaletteSuggestionsSearchNotifier({
    required this.child,
    required this.injector,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final BaseNamesInjector<Palette> injector;

  @override
  _PaletteSuggestionsSearchNotifierState createState() =>
      _PaletteSuggestionsSearchNotifierState();
}

class _PaletteSuggestionsSearchNotifierState
    extends State<PaletteSuggestionsSearchNotifier> {
  late final BaseNamesListViewModel<Palette> _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<NamesListState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => PaletteSuggestionsSearchData(
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
