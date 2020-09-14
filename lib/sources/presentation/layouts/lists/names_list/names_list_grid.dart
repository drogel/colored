import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/presentation/widgets/cards/single_color_card.dart';
import 'package:colored/sources/presentation/widgets/layouts/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 200.0;
const _kCrossAxisMinCount = 2;
const _kCrossAxisMaxCount = 9;

class NamesListGrid extends StatelessWidget {
  const NamesListGrid({
    @required this.namedColors,
    this.onCardPressed,
    Key key,
  }) : super(key: key);

  final List<NamedColor> namedColors;
  final void Function(Color) onCardPressed;

  @override
  Widget build(BuildContext context) => ResponsiveGrid<SingleColorCard>(
        pageStorageKeyId: 1,
        crossAxisMaxCount: _kCrossAxisMaxCount,
        crossAxisMinCount: _kCrossAxisMinCount,
        estimatedItemSize: _kEstimatedItemSize,
        items: namedColors
            .map(
              (namedColor) => SingleColorCard(
                backgroundColor: HexColor.fromHex(namedColor.hex),
                onPressed: onCardPressed,
                title: namedColor.name,
                subtitle: namedColor.hex,
              ),
            )
            .toList(),
      );
}
