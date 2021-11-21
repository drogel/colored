import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_data.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/presentation/widgets/cards/single_color_card.dart';
import 'package:colored/sources/presentation/widgets/lists/square_responsive_grid.dart';
import 'package:flutter/material.dart';

class NamesGrid extends StatefulWidget {
  const NamesGrid({
    required this.namedColors,
    this.searchString,
    this.pageStorageKey,
    this.onScrolledForwardNearBottom,
    Key? key,
  }) : super(key: key);

  final PageStorageKey<String>? pageStorageKey;
  final List<NamedColor> namedColors;
  final VoidCallback? onScrolledForwardNearBottom;
  final String? searchString;

  @override
  _NamesGridState createState() => _NamesGridState();
}

class _NamesGridState extends State<NamesGrid> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant NamesGrid oldWidget) {
    final currentSearch = widget.searchString;
    final previousSearch = oldWidget.searchString;
    final isSearchEmpty = currentSearch == null || currentSearch.isEmpty;
    final wasSearchEmpty = previousSearch == null || previousSearch.isEmpty;
    final didSearchChange = currentSearch != previousSearch;
    if (isSearchEmpty || wasSearchEmpty || didSearchChange) {
      _jumpToTop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => SquareResponsiveGrid(
      pageStorageKey: widget.pageStorageKey,
      scrollController: _scrollController,
      itemCount: widget.namedColors.length,
      onScrolledForwardNearBottom: widget.onScrolledForwardNearBottom,
      itemBuilder: (context, index) {
        final namedColor = widget.namedColors[index];
        return SingleColorCard(
          backgroundColor: HexColor.fromHex(namedColor.hex),
          onPressed: (color) => _notifyColorSelected(context, color),
          title: namedColor.name,
          subtitle: namedColor.hex,
        );
      });

  void _notifyColorSelected(BuildContext context, Color color) {
    final selection = ColorSelection.fromColor(color);
    final destinationIndex = MainTabsSelection.converter.index;
    FocusScope.of(context).unfocus();
    TransformerData.of(context)!.onSelectionEnded(selection);
    MainTabsData.of(context)!.onNavigation(destinationIndex);
  }

  void _jumpToTop() => _scrollController.jumpTo(0);
}
