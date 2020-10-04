import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_injector.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_view_model.dart';
import 'package:colored/sources/presentation/widgets/navigation/indexed_navigation_state.dart';
import 'package:flutter/material.dart';

class MainTabsNotifier extends StatefulWidget {
  const MainTabsNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        assert(child != null),
        super(key: key);

  final MainTabsInjector injector;
  final Widget child;

  @override
  _MainTabsNotifierState createState() => _MainTabsNotifierState();
}

class _MainTabsNotifierState extends State<MainTabsNotifier> {
  MainTabsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IndexedNavigationState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (_, snapshot) => MainTabsData(
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
