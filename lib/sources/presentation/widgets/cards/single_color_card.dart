import 'package:colored/sources/presentation/widgets/cards/color_card.dart';
import 'package:flutter/material.dart';

class SingleColorCard extends StatelessWidget {
  const SingleColorCard({
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final String title;
  final String subtitle;
  final void Function(Color)? onPressed;

  @override
  Widget build(BuildContext context) {
    final onPressed = this.onPressed;
    return ColorCard(
      title: Text(title),
      subtitle: Text(subtitle),
      backgroundColor: backgroundColor,
      onPressed: onPressed != null ? () => onPressed(backgroundColor) : null,
      child: Container(color: backgroundColor),
    );
  }
}
