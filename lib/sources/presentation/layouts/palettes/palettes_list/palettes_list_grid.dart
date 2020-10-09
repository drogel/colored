import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/data_models/palettes_navigation_selection.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:colored/sources/presentation/widgets/cards/palette_card.dart';
import 'package:colored/sources/presentation/widgets/layouts/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 325.0;
const _kCrossAxisMinCount = 1;
const _kCrossAxisMaxCount = 4;
const _kChildAspectRatio = 2.618;

class PalettesListGrid extends StatelessWidget {
  const PalettesListGrid({
    @required this.palettes,
    this.pageStorageKey,
    Key key,
  })  : assert(palettes != null),
        super(key: key);

  final PageStorageKey<String> pageStorageKey;
  final List<Palette> palettes;

  @override
  Widget build(BuildContext context) => ResponsiveGrid(
        pageStorageKey: pageStorageKey,
        estimatedItemSize: _kEstimatedItemSize,
        crossAxisMinCount: _kCrossAxisMinCount,
        crossAxisMaxCount: _kCrossAxisMaxCount,
        childAspectRatio: _kChildAspectRatio,
        items: palettes
            .map(
              (palette) => PaletteCard(
                colors: palette.hexCodes.map(HexColor.fromHex).toList(),
                title: palette.name,
                onPressed: (paletteName) => _onPaletteSelected(
                  context: context,
                  hexCodes: palette.hexCodes,
                  paletteName: paletteName,
                ),
              ),
            )
            .toList(),
      );

  void _onPaletteSelected({
    @required BuildContext context,
    @required List<String> hexCodes,
    @required String paletteName,
  }) {
    final destination = PalettesNavigationSelection.detail.index;
    PalettesNavigationData.of(context).onNavigation(destination);
    PaletteDetailData.of(context).onPaletteSelected(hexCodes, paletteName);
  }
}
