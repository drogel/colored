import 'package:flutter/cupertino.dart';
import 'package:colored/sources/style/colors.dart' as colors;
import 'package:colored/sources/style/opacities.dart' as opacities;

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 32),
    Key key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: colors.primary.withOpacity(opacities.overlay),
          boxShadow: [
            BoxShadow(
              color: colors.primaryDark.withOpacity(opacities.shadow),
              offset: const Offset(0, -2),
              blurRadius: 4,
            )
          ],
        ),
        child: child,
      );
}
