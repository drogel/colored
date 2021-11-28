import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  const GradientCircle({required this.hexCodes, Key? key}) : super(key: key);

  final List<String> hexCodes;

  @override
  Widget build(BuildContext context) {
    final gradientColors = _buildColors(hexCodes);
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(constraints.maxHeight / 2),
        ),
      ),
    );
  }

  List<Color> _buildColors(List<String> hexCodes) {
    final gradientColors = hexCodes.map(HexColor.fromHex).toList();
    if (gradientColors.length == 1) {
      final firstColor = gradientColors.first;
      return [firstColor, firstColor];
    } else {
      return gradientColors;
    }
  }
}
