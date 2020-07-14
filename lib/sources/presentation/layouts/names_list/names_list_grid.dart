import 'package:collection/collection.dart';
import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/presentation/widgets/cards/single_color_card.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 200;
const _kCrossAxisMinCount = 2;
const _kCrossAxisMaxCount = 9;

class NamesListGrid extends StatefulWidget {
  const NamesListGrid({
    @required this.namedColors,
    this.onCardPressed,
    Key key,
  }) : super(key: key);

  final List<NamedColor> namedColors;
  final void Function(Color) onCardPressed;

  @override
  _NamesListGridState createState() => _NamesListGridState();
}

class _NamesListGridState extends State<NamesListGrid> {
  final _pageStorageKey = const PageStorageKey<int>(1);
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(NamesListGrid oldWidget) {
    final areEqual = const ListEquality().equals;
    if (!areEqual(widget.namedColors, oldWidget.namedColors)) {
      final curve = CurveData.of(context).curveScheme.main;
      final duration = DurationData.of(context).durationScheme.mediumPresenting;
      _scrollController.animateTo(0, curve: curve, duration: duration);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = mediaQuery.viewInsets;
    final safeAreaPadding = mediaQuery.padding;
    return BackgroundContainer(
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (_, constraints) => GridView.builder(
            key: _pageStorageKey,
            controller: _scrollController,
            padding: padding.vertical.add(viewInsets).add(safeAreaPadding),
            itemCount: widget.namedColors.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _computeCrossAxisCount(constraints),
              childAspectRatio: 1,
            ),
            itemBuilder: (_, i) => SingleColorCard(
              backgroundColor: HexColor.fromHex(widget.namedColors[i].hex),
              onPressed: widget.onCardPressed,
              title: widget.namedColors[i].name,
              subtitle: widget.namedColors[i].hex,
            ),
          ),
        ),
      ),
    );
  }

  int _computeCrossAxisCount(BoxConstraints constraints) {
    final crossAxisCount = constraints.maxWidth ~/ _kEstimatedItemSize;
    return crossAxisCount.clamp(_kCrossAxisMinCount, _kCrossAxisMaxCount);
  }
}
