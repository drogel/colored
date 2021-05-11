import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class ColoredTooltip extends StatelessWidget {
  const ColoredTooltip({
    required this.message,
    this.tooltipKey,
    this.color,
    this.child,
    this.preferBelow = false,
    this.showOnMouseHover = false,
    Key? key,
  }) : super(key: key);

  final Key? tooltipKey;
  final bool showOnMouseHover;
  final bool preferBelow;
  final String message;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context)!.radiiScheme;
    final textStyle = Theme.of(context).textTheme.bodyText2;
    final padding = PaddingData.of(context)!.paddingScheme;
    return Tooltip(
      key: tooltipKey,
      message: message,
      textStyle: textStyle,
      padding: padding.large,
      margin: padding.small,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(radii.medium),
      ),
      preferBelow: preferBelow,
      waitDuration: _getWaitDuration(),
      child: child,
    );
  }

  // waitDuration is set to 1000 days to avoid tooltip showing on hovering.
  Duration _getWaitDuration() =>
      showOnMouseHover ? Duration.zero : const Duration(days: 1000);
}
