import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
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
    Key? key,
  })  : assert(itemBuilder != null),
        assert(itemCount != null),
        super(key: key);

  final double estimatedItemSize;
  final int crossAxisMinCount;
  final int crossAxisMaxCount;
  final PageStorageKey<String>? pageStorageKey;
  final double childAspectRatio;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  _ResponsiveGridState createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_dismissKeyboard);
    super.initState();
  }

  @override
  void didUpdateWidget(ResponsiveGrid oldWidget) {
    if (_isItemCountDifferent(oldWidget)) {
      _animateToTop(context);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = _computeEffectiveViewInsets(mediaQuery.viewInsets);
    final totalPadding = padding.vertical + viewInsets;
    return KeyboardDismisser(
      child: BackgroundContainer(
        child: OnlyPortraitScrollbar(
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

  void _animateToTop(BuildContext context) {
    final curve = CurveData.of(context)!.curveScheme.main;
    final duration = DurationData.of(context)!.durationScheme.mediumPresenting;
    _scrollController.animateTo(0, duration: duration, curve: curve);
  }

  void _dismissKeyboard() =>
      WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();

  bool _isItemCountDifferent(ResponsiveGrid oldWidget) =>
      oldWidget.itemCount != widget.itemCount;
}
