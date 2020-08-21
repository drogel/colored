import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:flutter/material.dart';

import 'base_chip.dart';

class GradientChip extends StatelessWidget {
  const GradientChip({
    @required this.text,
    @required this.startHex,
    @required this.endHex,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String text;
  final void Function(String) onPressed;
  final String startHex;
  final String endHex;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.medium);
    return BaseChip(
      text: text,
      avatar: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex(startHex),
              HexColor.fromHex(endHex),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
