import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/data_models/palettes_navigation_selection.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:colored/sources/presentation/widgets/cards/palette_card.dart';
import 'package:colored/sources/presentation/widgets/lists/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 325.0;
const _kCrossAxisMinCount = 1;
const _kCrossAxisMaxCount = 4;
const _kChildAspectRatio = 2.618;

class PalettesListGrid extends StatefulWidget {
  const PalettesListGrid({
    required this.palettes,
    this.searchString,
    this.pageStorageKey,
    this.onScrolledForwardNearBottom,
    Key? key,
  }) : super(key: key);

  final PageStorageKey<String>? pageStorageKey;
  final List<Palette> palettes;
  final VoidCallback? onScrolledForwardNearBottom;
  final String? searchString;

  @override
  _PalettesListGridState createState() => _PalettesListGridState();
}

class _PalettesListGridState extends State<PalettesListGrid> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant PalettesListGrid oldWidget) {
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
  Widget build(BuildContext context) => ResponsiveGrid(
      scrollController: _scrollController,
      pageStorageKey: widget.pageStorageKey,
      estimatedItemSize: _kEstimatedItemSize,
      crossAxisMinCount: _kCrossAxisMinCount,
      crossAxisMaxCount: _kCrossAxisMaxCount,
      childAspectRatio: _kChildAspectRatio,
      onScrolledForwardNearBottom: widget.onScrolledForwardNearBottom,
      itemCount: widget.palettes.length,
      itemBuilder: (context, index) {
        final palette = widget.palettes[index];
        return PaletteCard(
          colors: palette.hexCodes.map(HexColor.fromHex).toList(),
          title: palette.name,
          onPressed: (paletteName) => _onPaletteSelected(
            context: context,
            hexCodes: palette.hexCodes,
            paletteName: paletteName,
          ),
        );
      });

  void _onPaletteSelected({
    required BuildContext context,
    required List<String> hexCodes,
    required String paletteName,
  }) {
    final destination = PalettesNavigationSelection.detail.index;
    PalettesNavigationData.of(context)!.onNavigation(destination);
    PaletteDetailData.of(context)!.onPaletteSelected(hexCodes, paletteName);
  }

  void _jumpToTop() => _scrollController.jumpTo(0);
}
