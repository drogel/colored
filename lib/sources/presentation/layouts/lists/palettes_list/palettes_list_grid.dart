import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/presentation/widgets/cards/palette_card.dart';
import 'package:colored/sources/presentation/widgets/layouts/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 325.0;
const _kCrossAxisMinCount = 1;
const _kCrossAxisMaxCount = 4;
const _kChildAspectRatio = 2.618;

class PalettesListGrid extends StatelessWidget {
  const PalettesListGrid({@required this.palettes, Key key})
      : assert(palettes != null),
        super(key: key);

  final List<Palette> palettes;

  @override
  Widget build(BuildContext context) => ResponsiveGrid<PaletteCard>(
        pageStorageKeyId: 2,
        estimatedItemSize: _kEstimatedItemSize,
        crossAxisMinCount: _kCrossAxisMinCount,
        crossAxisMaxCount: _kCrossAxisMaxCount,
        childAspectRatio: _kChildAspectRatio,
        items: palettes
            .map(
              (palette) => PaletteCard(
                colors: palette.hexCodes.map(HexColor.fromHex).toList(),
                title: palette.name,
              ),
            )
            .toList(),
      );
}
