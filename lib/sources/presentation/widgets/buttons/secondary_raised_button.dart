import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';

class SecondaryRaisedButton extends RaisedButton {
  const SecondaryRaisedButton({
    @required void Function() onPressed,
    @required Widget child,
    Key key,
  }) : super(onPressed: onPressed, child: child, key: key);

  @override
  Color get color => colors.primary;

  @override
  Color get splashColor => colors.secondary.withOpacity(opacities.fadedColor);

  @override
  Color get highlightColor =>
      colors.secondaryDark.withOpacity(opacities.shadow);

  @override
  ShapeBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

  @override
  EdgeInsetsGeometry get padding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
}
