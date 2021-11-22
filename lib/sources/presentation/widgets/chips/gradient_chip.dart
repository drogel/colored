import 'package:colored/sources/presentation/widgets/chips/suggestion_chip.dart';
import 'package:colored/sources/presentation/widgets/containers/gradient_circle.dart';
import 'package:flutter/material.dart';

class GradientChip extends StatelessWidget {
  const GradientChip({
    required this.text,
    required this.hexCodes,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function(String)? onPressed;
  final List<String> hexCodes;

  @override
  Widget build(BuildContext context) => SuggestionChip(
        text: text,
        avatar: GradientCircle(hexCodes: hexCodes),
        onPressed: onPressed,
      );
}
