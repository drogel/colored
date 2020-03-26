import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_body_layout.dart';
import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;

class OnBoardingButtonsLayout extends StatelessWidget {
  const OnBoardingButtonsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localization = Localization.of(context).onBoarding;
    return OnBoardingBodyLayout(
      children: <Widget>[
        const SizedBox(height: padding.largeText),
        Flexible(
          child: Column(
            children: <Widget>[
              Text(
                localization.longPress,
                style: textTheme.display3,
                textAlign: TextAlign.center,
              ),
              Text(
                localization.longPressBody,
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: <Widget>[
              Text(
                localization.tap,
                style: textTheme.display3,
                textAlign: TextAlign.center,
              ),
              Text(
                localization.tapBody,
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Flexible(
          child: Container(),
        ),
      ],
    );
  }
}
