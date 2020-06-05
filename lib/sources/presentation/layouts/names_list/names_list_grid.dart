import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:colored/sources/presentation/widgets/containers/color_card.dart';
import 'package:flutter/material.dart';

const _kEstimatedItemSize = 200;
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
  Widget build(BuildContext context) {
    const pageStorageKey = PageStorageKey<int>(1);
    final padding = PaddingData.of(context).paddingScheme;
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = mediaQuery.viewInsets;
    final safeAreaPadding = mediaQuery.padding;
    return BackgroundContainer(
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (_, constraints) => GridView.builder(
            key: pageStorageKey,
            padding: padding.vertical.add(viewInsets).add(safeAreaPadding),
            itemCount: namedColors.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _computeCrossAxisCount(constraints),
              childAspectRatio: 1,
            ),
            itemBuilder: (_, i) => ColorCard(
              backgroundColor: HexColor.fromHex(namedColors[i].hex),
              onPressed: onCardPressed,
              title: namedColors[i].name,
              subtitle: namedColors[i].hex,
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
