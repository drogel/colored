import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_grid.dart';
import 'package:colored/sources/presentation/layouts/palettes/palette_detail/palette_detail_loading_grid.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

class PaletteDetailLayout extends StatelessWidget {
  const PaletteDetailLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = PaletteDetailData.of(context).state;
    switch (state.runtimeType) {
      case Pending:
        final pending = state as Pending;
        return PaletteDetailLoadingGrid(hexCodes: pending.requestedHexCodes);
      case PaletteFound:
        final found = state as PaletteFound;
        return NamesGrid(namedColors: found.namedColors);
      default:
        return const BackgroundContainer();
    }
  }
}
