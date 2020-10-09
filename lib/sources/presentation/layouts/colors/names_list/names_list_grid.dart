import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/presentation/widgets/cards/single_color_card.dart';
import 'package:colored/sources/presentation/widgets/layouts/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 200.0;
const _kCrossAxisMinCount = 2;
const _kCrossAxisMaxCount = 9;

class NamesListGrid extends StatelessWidget {
  const NamesListGrid({
    @required this.namedColors,
    this.pageStorageKey,
    Key key,
  }) : super(key: key);

  final PageStorageKey<String> pageStorageKey;
  final List<NamedColor> namedColors;

  @override
  Widget build(BuildContext context) => ResponsiveGrid(
        pageStorageKey: pageStorageKey,
        crossAxisMaxCount: _kCrossAxisMaxCount,
        crossAxisMinCount: _kCrossAxisMinCount,
        estimatedItemSize: _kEstimatedItemSize,
        items: namedColors
            .map(
              (namedColor) => SingleColorCard(
                backgroundColor: HexColor.fromHex(namedColor.hex),
                onPressed: (color) => _notifyColorSelected(context, color),
                title: namedColor.name,
                subtitle: namedColor.hex,
              ),
            )
            .toList(),
      );

  void _notifyColorSelected(BuildContext context, Color color) {
    final selection = ColorSelection.fromColor(color);
    final destinationIndex = MainTabsSelection.converter.index;
    FocusScope.of(context).unfocus();
    TransformerData.of(context).onSelectionEnded(selection);
    MainTabsData.of(context).onNavigation(destinationIndex);
  }
}
