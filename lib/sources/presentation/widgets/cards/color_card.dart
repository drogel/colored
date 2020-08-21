import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/cards/color_card_tile.dart';
import 'package:colored/sources/presentation/widgets/cards/floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({
    @required this.title,
    this.subtitle,
    this.onPressed,
    this.child,
    this.backgroundColor,
    Key key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget child;
  final Color backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    return Padding(
      padding: padding.medium,
      child: FloatingCard(
        backgroundColor: backgroundColor,
        child: Stack(
          children: [
            child,
            Material(
              color: Colors.transparent,
              child: InkWell(onTap: onPressed),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ColorCardTile(
                title: title,
                subtitle: subtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
