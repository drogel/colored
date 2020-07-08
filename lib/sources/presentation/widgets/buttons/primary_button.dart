import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    @required this.title,
    @required this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.padding,
    Key key,
  }) : super(key: key);

  final String title;
  final void Function() onPressed;
  final void Function() onLongPress;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context).radiiScheme;
    final textStyle = Theme.of(context).textTheme.headline6;
    final paddingScheme = PaddingData.of(context).paddingScheme;
    return RaisedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radii.medium),
      ),
      padding: padding ?? paddingScheme.large,
      child: Text(title, style: textStyle, textScaleFactor: 0.77),
    );
  }
}
