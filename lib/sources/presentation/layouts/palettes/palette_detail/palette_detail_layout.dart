import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_list_grid.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class PaletteDetailLayout extends StatelessWidget {
  const PaletteDetailLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = PaletteDetailData.of(context).state;
    switch (state.runtimeType) {
      case Failed:
        return const BackgroundContainer();
      case PaletteFound:
        final foundState = state as PaletteFound;
        return NamesListGrid(namedColors: foundState.namedColors);
      default:
        return const BackgroundContainer();
    }
  }
}
