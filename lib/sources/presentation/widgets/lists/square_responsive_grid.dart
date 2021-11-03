import 'package:colored/sources/presentation/widgets/lists/responsive_grid.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 200.0;
const _kCrossAxisMinCount = 2;
const _kCrossAxisMaxCount = 9;

class SquareResponsiveGrid extends StatelessWidget {
  const SquareResponsiveGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.onScrolledForwardNearBottom,
    this.pageStorageKey,
    Key? key,
  }) : super(key: key);

  final PageStorageKey<String>? pageStorageKey;
  final int itemCount;
  final VoidCallback? onScrolledForwardNearBottom;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) => ResponsiveGrid(
        pageStorageKey: pageStorageKey,
        crossAxisMaxCount: _kCrossAxisMaxCount,
        crossAxisMinCount: _kCrossAxisMinCount,
        estimatedItemSize: _kEstimatedItemSize,
        itemCount: itemCount,
		onScrolledForwardNearBottom: onScrolledForwardNearBottom,
		nearBottomEdgeThreshold: 1.5 * _kEstimatedItemSize,
        itemBuilder: itemBuilder,
      );
}
