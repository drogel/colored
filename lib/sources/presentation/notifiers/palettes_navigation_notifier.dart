import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_view_model.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter/material.dart';

class PalettesNavigationNotifier extends StatefulWidget {
  const PalettesNavigationNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  }) : super(key: key);

  final PalettesNavigationInjector injector;
  final Widget child;

  @override
  _PalettesNavigationNotifierState createState() =>
      _PalettesNavigationNotifierState();
}

class _PalettesNavigationNotifierState
    extends State<PalettesNavigationNotifier> {
  PalettesNavigationViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IndexedNavigationState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => PalettesNavigationData(
          state: snapshot.data,
          onNavigation: _viewModel.navigateToIndex,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
