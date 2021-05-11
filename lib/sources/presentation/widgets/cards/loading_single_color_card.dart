import 'package:colored/sources/presentation/widgets/cards/color_card.dart';
import 'package:colored/sources/presentation/widgets/containers/loading_text_cover.dart';
import 'package:flutter/material.dart';

class LoadingSingleColorCard extends StatelessWidget {
  const LoadingSingleColorCard({
    required this.backgroundColor,
    required this.subtitle,
    this.titleWidthFraction = 0.84,
    this.subtitleWidthFraction = 0.56,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final String subtitle;
  final double titleWidthFraction;
  final double subtitleWidthFraction;

  @override
  Widget build(BuildContext context) => ColorCard(
        title: LoadingTextCover(parentWidthFraction: titleWidthFraction),
        subtitle: LoadingTextCover(parentWidthFraction: subtitleWidthFraction),
        backgroundColor: backgroundColor,
        child: Container(color: backgroundColor),
      );
}
