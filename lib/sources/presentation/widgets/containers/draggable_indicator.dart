import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

const double _kIndicatorHeight = 5;
const double _kIndicatorWidth = 36;

class DraggableIndicator extends StatelessWidget {
  const DraggableIndicator({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radii = RadiusData.of(context)!.radiiScheme;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: _kIndicatorWidth,
          height: _kIndicatorHeight,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(radii.small),
            color: theme.buttonColor,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Container(
            height: 4 * _kIndicatorHeight,
            width: 5 * _kIndicatorWidth,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
