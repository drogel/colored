import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_injector.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_view_model.dart';
import 'package:flutter/material.dart';

class NamesListPage extends StatefulWidget {
  const NamesListPage({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        assert(child != null),
        super(key: key);

  final Widget child;
  final NamesListInjector injector;

  @override
  _NamesListPageState createState() => _NamesListPageState();
}

class _NamesListPageState extends State<NamesListPage> {
  NamesListViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<NamesListState>(
        initialData: _viewModel.initialData,
        stream: _viewModel.stateStream,
        builder: (_, snapshot) => NamesListData(
          state: snapshot.data,
          child: widget.child,
        ),
      );
}
