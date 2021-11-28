import 'package:colored/sources/presentation/widgets/chips/suggestion_chip.dart';
import 'package:colored/sources/presentation/widgets/containers/gradient_circle.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  const ColorChip({
    required this.text,
    required this.colorHex,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function(String)? onPressed;
  final String colorHex;

  @override
  Widget build(BuildContext context) => SuggestionChip(
        text: text,
        avatar: GradientCircle(hexCodes: [colorHex]),
        onPressed: onPressed,
      );
}
