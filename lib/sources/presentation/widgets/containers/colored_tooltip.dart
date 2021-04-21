import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class ColoredTooltip extends StatelessWidget {
  const ColoredTooltip({
    Key? key,
    this.tooltipKey,
    this.message,
    this.color,
    this.child,
    this.preferBelow = false,
    this.showOnMouseHover = false,
  }) : super(key: key);

  final Key? tooltipKey;
  final bool showOnMouseHover;
  final bool preferBelow;
  final String? message;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final radii = RadiusData.of(context)!.radiiScheme;
    return Tooltip(
      key: tooltipKey,
      message: message!,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(radii.small),
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
