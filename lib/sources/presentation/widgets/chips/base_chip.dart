import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class BaseChip extends StatelessWidget {
  const BaseChip({
    @required this.text,
    @required this.avatar,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final void Function(String) onPressed;
  final String text;
  final Widget avatar;

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
        avatar: avatar,
        label: Text(text),
        labelStyle: textTheme.bodyText1,
      ),
    );
  }
}
