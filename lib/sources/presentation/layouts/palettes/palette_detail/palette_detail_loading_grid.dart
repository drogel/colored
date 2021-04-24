import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/presentation/widgets/cards/loading_single_color_card.dart';
import 'package:colored/sources/presentation/widgets/lists/square_responsive_grid.dart';
import 'package:flutter/material.dart';

class PaletteDetailLoadingGrid extends StatelessWidget {
  const PaletteDetailLoadingGrid({
    required this.hexCodes,
    this.pageStorageKey,
    Key? key,
  }) : super(key: key);

  final PageStorageKey<String>? pageStorageKey;
  final List<String> hexCodes;

  @override
  Widget build(BuildContext context) => SquareResponsiveGrid(
        pageStorageKey: PageStorageKey(runtimeType.toString()),
        itemCount: hexCodes.length,
        itemBuilder: (context, index) {
          final hexCode = hexCodes[index];
          return LoadingSingleColorCard(
            backgroundColor: HexColor.fromHex(hexCode),
            subtitle: hexCode,
          );
        },
      );
}
