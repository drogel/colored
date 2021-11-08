import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_injector.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_view_model.dart';
import 'package:flutter/material.dart';

class NamesListNotifier extends StatefulWidget {
  const NamesListNotifier({
    required this.injector,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final NamesListInjector injector;

  @override
  _NamesListNotifierState createState() => _NamesListNotifierState();
}

class _NamesListNotifierState extends State<NamesListNotifier> {
  late final NamesListViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<NamesListState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (_, snapshot) => NamesListData(
          state: snapshot.data ?? _viewModel.initialState,
          onSearchChanged: _viewModel.searchNextPage,
          onSearchStarted: _viewModel.startSearch,
          onSearchCleared: _viewModel.clearSearch,
          onBackPressed: _viewModel.clearSearch,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
