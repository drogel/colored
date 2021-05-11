import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DynamicBottomPadding extends StatelessWidget {
  const DynamicBottomPadding({
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    final deviceSafeArea = MediaQuery.of(context).padding;
    return SafeArea(
      child: OrientationBuilder(
        builder: (_, orientation) => Padding(
          padding: _getOuterPadding(orientation, deviceSafeArea, padding),
          child: child,
        ),
      ),
    );
  }

  EdgeInsets _getOuterPadding(
    Orientation orientation,
    EdgeInsets deviceSafeArea,
    PaddingScheme paddingScheme,
  ) {
    if (kIsWeb) {
      return paddingScheme.large;
    } else {
      if (orientation == Orientation.portrait) {
        return deviceSafeArea.bottom == 0
            ? paddingScheme.small
            : EdgeInsets.symmetric(horizontal: deviceSafeArea.bottom / 2);
      } else {
        return paddingScheme.small;
      }
    }
  }
}
