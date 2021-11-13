import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:colored/sources/presentation/widgets/lists/only_portrait_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ResponsiveGrid extends StatefulWidget {
  const ResponsiveGrid({
    required this.itemBuilder,
    required this.itemCount,
    this.pageStorageKey,
    this.estimatedItemSize = 200,
    this.crossAxisMinCount = 2,
    this.crossAxisMaxCount = 9,
    this.childAspectRatio = 1,
    this.onScrolledForwardNearBottom,
    this.nearBottomEdgeThreshold = 0,
    this.scrollController,
    Key? key,
  }) : super(key: key);

  final double estimatedItemSize;
  final int crossAxisMinCount;
  final int crossAxisMaxCount;
  final PageStorageKey<String>? pageStorageKey;
  final double childAspectRatio;
  final int itemCount;
  final VoidCallback? onScrolledForwardNearBottom;
  final double nearBottomEdgeThreshold;
  final ScrollController? scrollController;
  final IndexedWidgetBuilder itemBuilder;

  @override
  _ResponsiveGridState createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  late final ScrollController _scrollController;
  late double _lastExtentAfter;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScrolledForwardNearBottom);
    _lastExtentAfter = double.infinity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = _computeEffectiveViewInsets(mediaQuery.viewInsets);
    final totalPadding = padding.vertical + viewInsets;
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onVerticalDragDown],
      child: BackgroundContainer(
        child: OnlyPortraitScrollbar(
          scrollController: _scrollController,
          child: SafeArea(
            bottom: false,
            top: false,
            child: LayoutBuilder(
              builder: (_, constraints) => GridView.builder(
                key: widget.pageStorageKey,
                controller: _scrollController,
                padding: totalPadding,
                itemCount: widget.itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _computeCrossAxisCount(constraints),
                  childAspectRatio: widget.childAspectRatio,
                ),
                itemBuilder: widget.itemBuilder,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _computeCrossAxisCount(BoxConstraints constraints) {
    final minCount = widget.crossAxisMinCount;
    final maxCount = widget.crossAxisMaxCount;
    final crossAxisCount = constraints.maxWidth ~/ widget.estimatedItemSize;
    return crossAxisCount.clamp(minCount, maxCount);
  }

  EdgeInsets _computeEffectiveViewInsets(EdgeInsets viewInsets) {
    if (viewInsets.bottom != 0) {
      const bottomInsets = EdgeInsets.only(bottom: kBottomNavigationBarHeight);
      return viewInsets.subtract(bottomInsets) as EdgeInsets;
    } else {
      return viewInsets;
    }
  }

  void _onScrolledForwardNearBottom() {
    final onScrolledForwardNearBottom = widget.onScrolledForwardNearBottom;
    if (onScrolledForwardNearBottom == null) {
      return;
    }
    final extentAfter = _scrollController.position.extentAfter;
    final threshold = widget.nearBottomEdgeThreshold;
    final isPastThreshold = extentAfter <= threshold;
    final wasBelowThreshold = _lastExtentAfter >= threshold;
    final isScrollNearBottomEdge = wasBelowThreshold && isPastThreshold;
    _lastExtentAfter = extentAfter;
    if (isScrollNearBottomEdge) {
      onScrolledForwardNearBottom();
    }
  }
}
