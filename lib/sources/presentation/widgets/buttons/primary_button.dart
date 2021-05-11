import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    required this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.padding,
    Key? key,
  }) : super(key: key);

  final String title;
  final void Function() onPressed;
  final void Function()? onLongPress;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context)!.radiiScheme;
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.headline6;
    final paddingScheme = PaddingData.of(context)!.paddingScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: colors.secondary,
        padding: padding ?? paddingScheme.large,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radii.medium),
        ),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Text(title, style: textStyle, textScaleFactor: 0.77),
    );
  }
}
