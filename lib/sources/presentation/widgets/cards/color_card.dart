import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/cards/color_card_tile.dart';
import 'package:colored/sources/presentation/widgets/cards/floating_card.dart';
import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({
    required this.title,
    this.onPressed,
    this.subtitle,
    this.child,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? child;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    return Padding(
      padding: padding.medium,
      child: FloatingCard(
        backgroundColor: backgroundColor,
        child: Stack(
          children: [
            if (child != null) child!,
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
