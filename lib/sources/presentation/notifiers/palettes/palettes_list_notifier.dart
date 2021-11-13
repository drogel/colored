import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_data.dart';
import 'package:flutter/material.dart';

class PalettesListNotifier extends StatefulWidget {
  const PalettesListNotifier({
    required this.injector,
    required this.child,
    Key? key,
  }) : super(key: key);

  final BaseNamesInjector<Palette> injector;
  final Widget child;

  @override
  _PalettesListNotifierState createState() => _PalettesListNotifierState();
}

class _PalettesListNotifierState extends State<PalettesListNotifier> {
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
        builder: (context, snapshot) => PalettesListData(
          state: snapshot.data ?? _viewModel.initialState,
          onSearchChanged: _viewModel.searchNextPage,
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
