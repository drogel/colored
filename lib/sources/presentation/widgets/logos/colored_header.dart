import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/logos/colored_logo.dart';
import 'package:flutter/material.dart';

class ColoredHeader extends StatelessWidget {
  const ColoredHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline3;
    final localization = Localization.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(localization.appTitle, style: textStyle),
        const ColoredLogo(),
      ],
    );
  }
}
