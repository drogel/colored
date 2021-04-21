import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/presentation/widgets/chips/suggestion_chip.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  const ColorChip({
    required this.text,
    required this.colorHex,
    this.onPressed,
    Key? key,
  })  : assert(text != null),
        assert(colorHex != null),
        super(key: key);

  final String text;
  final void Function(String)? onPressed;
  final String colorHex;

  @override
  Widget build(BuildContext context) {
    final borderRadius = RadiusData.of(context)!.radiiScheme.medium;
    return SuggestionChip(
      text: text,
      avatar: Container(
        decoration: BoxDecoration(
          color: HexColor.fromHex(colorHex),
          borderRadius: BorderRadius.all(borderRadius),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
