import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_view_model.dart';
import 'package:flutter/material.dart';

class PalettesListNotifier extends StatefulWidget {
  const PalettesListNotifier({
    required this.injector,
    required this.child,
    Key? key,
  }) : super(key: key);

  final PalettesListInjector injector;
  final Widget child;

  @override
  _PalettesListNotifierState createState() => _PalettesListNotifierState();
}

class _PalettesListNotifierState extends State<PalettesListNotifier> {
  late PalettesListViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PalettesListState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => PalettesListData(
          state: snapshot.data ?? _viewModel.initialState,
          onSearchChanged: _viewModel.searchPalettes,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
