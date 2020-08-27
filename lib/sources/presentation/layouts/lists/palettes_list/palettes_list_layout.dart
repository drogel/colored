import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/presentation/layouts/lists/palettes_list/no_palettes_message.dart';
import 'package:colored/sources/presentation/layouts/lists/palettes_list/palettes_list_grid.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class PalettesListLayout extends StatelessWidget {
  const PalettesListLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = PalettesListData.of(context).state;
    switch (state.runtimeType) {
      case NoneFound:
        return const NoPalettesMessage();
      case Found:
        final foundState = state as Found;
        return PalettesListGrid(palettes: foundState.palettes);
      default:
        return const BackgroundContainer();
    }
  }
}
