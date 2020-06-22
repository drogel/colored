import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  const ColorChip({
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
    final padding = PaddingData.of(context).paddingScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.medium);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final horizontalPadding = padding.small.horizontal;
    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding),
      child: InputChip(
        onPressed: onPressed != null ? () => onPressed(text) : null,
        backgroundColor: colors.primaryVariant,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        avatar: Container(
          decoration: BoxDecoration(
            color: HexColor.fromHex(colorHex),
            borderRadius: borderRadius,
          ),
        ),
        label: Text(text),
        labelStyle: textTheme.bodyText1,
      ),
    );
  }
}
