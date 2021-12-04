import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/presentation/widgets/containers/gradient_circle.dart';
import 'package:flutter/material.dart';

const _kOptionLeadingSize = 24.0;

class AutocompleteOptionTile extends StatelessWidget {
  const AutocompleteOptionTile({
    required this.title,
    required this.hexCodes,
    this.onTap,
    this.isHighlighted = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<String> hexCodes;
  final bool isHighlighted;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context)!.radiiScheme;
    final opacityScheme = OpacityData.of(context)!.opacityScheme;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Ink(
      decoration: BoxDecoration(
        color: _optionColor(colorScheme, opacityScheme: opacityScheme),
        borderRadius: BorderRadius.all(radii.small),
      ),
      child: ListTile(
        leading: SizedBox(
          height: _kOptionLeadingSize,
          width: _kOptionLeadingSize,
          child: GradientCircle(hexCodes: hexCodes),
        ),
        horizontalTitleGap: 0,
        title: Text(title, style: textTheme.bodyText1),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radii.small),
        ),
      ),
    );
  }

  Color _optionColor(
    ColorScheme colorScheme, {
    required OpacityScheme opacityScheme,
  }) =>
      isHighlighted
          ? colorScheme.secondaryVariant.withOpacity(opacityScheme.shadow)
          : colorScheme.primaryVariant;
}
