import 'package:collection/collection.dart';
import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:colored/sources/presentation/widgets/layouts/only_portrait_scrollbar.dart';
import 'package:flutter/material.dart';

class ResponsiveGrid<T> extends StatefulWidget {
  const ResponsiveGrid({
    @required this.items,
    @required this.pageStorageKeyId,
    this.estimatedItemSize = 200,
    this.crossAxisMinCount = 2,
    this.crossAxisMaxCount = 9,
    this.childAspectRatio = 1,
    Key key,
  })  : assert(items != null),
        assert(pageStorageKeyId != null),
        super(key: key);

  final double estimatedItemSize;
  final int crossAxisMinCount;
  final int crossAxisMaxCount;
  final int pageStorageKeyId;
  final double childAspectRatio;
  final List<T> items;

  @override
  _ResponsiveGridState createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  final _scrollController = ScrollController();
  PageStorageKey<int> _pageStorageKey;

  @override
  void didUpdateWidget(ResponsiveGrid oldWidget) {
    final areEqual = const ListEquality().equals;
    if (!areEqual(widget.items, oldWidget.items)) {
      final curve = CurveData.of(context).curveScheme.main;
      final duration = DurationData.of(context).durationScheme.mediumPresenting;
      _scrollController.animateTo(0, duration: duration, curve: curve);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = _computeEffectiveViewInsets(mediaQuery.viewInsets);
    return BackgroundContainer(
      child: OnlyPortraitScrollbar(
        child: SafeArea(
          bottom: false,
          top: false,
          child: LayoutBuilder(
            builder: (_, constraints) => GridView.builder(
              key: _pageStorageKey,
              controller: _scrollController,
              padding: padding.vertical.add(viewInsets),
              itemCount: widget.items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _computeCrossAxisCount(constraints),
                childAspectRatio: widget.childAspectRatio,
              ),
              itemBuilder: (_, i) => widget.items[i],
            ),
          ),
        ),
      ),
    );
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
      return viewInsets.subtract(bottomInsets);
    } else {
      return viewInsets;
    }
  }
}
