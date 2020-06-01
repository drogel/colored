import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/radii.dart' as radii;
import 'file:///D:/Programas/Flutter/colored/colored/lib/sources/app/styling/padding/padding_constants.dart' as paddings;

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    @required this.title,
    @required this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.padding = paddings.medium,
    Key key,
  }) : super(key: key);

  final String title;
  final void Function() onPressed;
  final void Function() onLongPress;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline6;
    return RaisedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radii.medium),
      ),
      padding: padding,
      child: Text(title, style: textStyle, textScaleFactor: 1),
    );
  }
}
