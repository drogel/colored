import 'package:colored/sources/presentation/layouts/converter_page/converter_page_body.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';
import 'package:flutter/material.dart';

import 'converter_page_app_bar.dart';

class ConverterPageLayout extends StatefulWidget {
  const ConverterPageLayout({Key key}) : super(key: key);

  @override
  _ConverterPageLayoutState createState() => _ConverterPageLayoutState();
}

class _ConverterPageLayoutState extends State<ConverterPageLayout> {
  CrossSwitcherState searchingState = CrossSwitcherState.showFirst;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ConverterPageAppBar(
          searchingState: searchingState,
          onSearchStateChange: _updateSearchingState,
        ),
        body: ConverterPageBody(
          searchingState: searchingState,
          onSearchStateChange: _updateSearchingState,
        ),
      );

  void _updateSearchingState() => setState(
        () => searchingState = searchingState.switched(),
      );
}
