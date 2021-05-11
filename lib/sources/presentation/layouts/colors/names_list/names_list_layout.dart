import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_grid.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/no_colors_message.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = NamesListData.of(context)!.state;
    switch (state.runtimeType) {
      case NoneFound:
        return const NoColorsMessage();
      case Found:
        final foundState = state as Found;
        return NamesGrid(
          pageStorageKey: PageStorageKey(runtimeType.toString()),
          namedColors: foundState.namedColors,
        );
      default:
        return const BackgroundContainer();
    }
  }
}
