import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/common/extensions/hex_color.dart';
import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  const ColorChip({
    @required this.text,
    @required this.colorHex,
    Key key,
  }) : super(key: key);

  final String text;
  final String colorHex;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final horizontalPadding = padding.small.horizontal;
    return Padding(
      padding: EdgeInsets.only(left: horizontalPadding),
      child: Chip(
        backgroundColor: colors.primaryVariant,
        avatar: ClipOval(
          child: Container(color: HexColor.fromHex(colorHex)),
        ),
        label: Text(text),
        labelStyle: textTheme.bodyText1,
      ),
    );
  }
}
