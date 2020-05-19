import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:colored/sources/presentation/widgets/containers/color_card.dart';
import 'package:flutter/material.dart';

class NamesListGrid extends StatelessWidget {
  const NamesListGrid({@required this.namedColors, Key key}) : super(key: key);

  final List<NamedColor> namedColors;

  @override
  Widget build(BuildContext context) => BackgroundContainer(
        child: GridView.builder(
          padding: padding.lists,
          itemCount: namedColors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, i) => ColorCard(
            backgroundColor: HexColor.fromHex(namedColors[i].hex),
            title: namedColors[i].name,
            subtitle: namedColors[i].hex,
          ),
        ),
      );
}
