import 'package:colored/sources/presentation/widgets/lists/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 200.0;
const _kCrossAxisMinCount = 2;
const _kCrossAxisMaxCount = 9;
const _kNearBottomEdgeThreshold = 2.5 * _kEstimatedItemSize;

class SquareResponsiveGrid extends StatelessWidget {
  const SquareResponsiveGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.scrollController,
    this.onScrolledForwardNearBottom,
    this.pageStorageKey,
    Key? key,
  }) : super(key: key);

  final PageStorageKey<String>? pageStorageKey;
  final int itemCount;
  final VoidCallback? onScrolledForwardNearBottom;
  final ScrollController? scrollController;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) => ResponsiveGrid(
        pageStorageKey: pageStorageKey,
        scrollController: scrollController,
        crossAxisMaxCount: _kCrossAxisMaxCount,
        crossAxisMinCount: _kCrossAxisMinCount,
        estimatedItemSize: _kEstimatedItemSize,
        itemCount: itemCount,
        onScrolledForwardNearBottom: onScrolledForwardNearBottom,
        nearBottomEdgeThreshold: _kNearBottomEdgeThreshold,
        itemBuilder: itemBuilder,
      );
}
