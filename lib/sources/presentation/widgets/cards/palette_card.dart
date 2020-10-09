import 'package:colored/sources/presentation/widgets/cards/color_card.dart';
import 'package:flutter/material.dart';

class PaletteCard extends StatelessWidget {
  const PaletteCard({
    @required this.colors,
    @required this.title,
    this.subtitle,
    this.onPressed,
    Key key,
  })  : assert(colors != null),
        assert(title != null),
        super(key: key);

  final List<Color> colors;
  final String title;
  final String subtitle;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) => ColorCard(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => onPressed(title),
        child: RepaintBoundary(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: colors
                .map((color) => Expanded(child: Container(color: color)))
                .toList(),
          ),
        ),
      );
}
