import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/presentation/widgets/chips/suggestion_chip.dart';
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
  Widget build(BuildContext context) {
    final gradientColors = hexCodes.map(HexColor.fromHex).toList();
    final borderRadius = RadiusData.of(context)!.radiiScheme.medium;
    return SuggestionChip(
      text: text,
      avatar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(borderRadius),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
