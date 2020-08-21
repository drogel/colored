import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:colored/sources/presentation/widgets/chips/base_chip.dart';
import 'package:flutter/material.dart';

class SingleColorChip extends StatelessWidget {
  const SingleColorChip({
    @required this.text,
    @required this.colorHex,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String text;
  final String colorHex;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.medium);
    return BaseChip(
      text: text,
      avatar: Container(
        decoration: BoxDecoration(
          color: HexColor.fromHex(colorHex),
          borderRadius: borderRadius,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
