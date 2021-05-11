import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class OnlyPortraitScrollbar extends StatelessWidget {
  const OnlyPortraitScrollbar({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isLandscape = _isDeviceInLandscapeOrientation(context);
    final hasHorizontalSafeArea = _hasDeviceHorizontalSafeArea(context);

    if (hasHorizontalSafeArea && isLandscape) {
      return child;
    } else {
      final radius = RadiusData.of(context)!.radiiScheme;
      return Scrollbar(radius: radius.small, child: child);
    }
  }

  bool _isDeviceInLandscapeOrientation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape;
  }

  bool _hasDeviceHorizontalSafeArea(BuildContext context) {
    final safeArea = MediaQuery.of(context).viewPadding;
    return safeArea.right != 0 || safeArea.left != 0;
  }
}
