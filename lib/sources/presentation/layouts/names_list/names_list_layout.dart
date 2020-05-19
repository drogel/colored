import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_grid.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = NamesListData.of(context).state;
    switch (state.runtimeType) {
      case Found:
        final foundState = state as Found;
        return NamesListGrid(namedColors: foundState.namedColors);
      default:
        return const BackgroundContainer();
    }
  }
}
