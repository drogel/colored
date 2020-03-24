import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_body_layout.dart';
import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;

class OnBoardingSlidersLayout extends StatelessWidget {
  const OnBoardingSlidersLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localization = Localization.of(context).onBoarding;
    return OnBoardingBodyLayout(
      children: <Widget>[
        Text(
          localization.useSliders,
          style: textTheme.display3,
          textAlign: TextAlign.center,
        ),
        Text(
          localization.useSlidersBody,
          style: textTheme.headline,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2 * padding.largeText),
        Text(
          localization.useSlidersFooter,
          style: textTheme.headline,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.7 * padding.largeText),
      ],
    );
  }
}
