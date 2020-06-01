import 'package:auto_size_text/auto_size_text.dart';
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_body_layout.dart';
import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding/padding_constants.dart' as padding;

class OnBoardingButtonsLayout extends StatelessWidget {
  const OnBoardingButtonsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localization = Localization.of(context).onBoarding;
    return OnBoardingBodyLayout(
      children: <Widget>[
        const SizedBox(height: padding.base),
        Flexible(
          flex: 4,
          child: Column(
            children: <Widget>[
              AutoSizeText(
                localization.longPress,
                maxLines: 1,
                style: textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                localization.longPressBody,
                maxLines: 2,
                style: textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: padding.base),
              AutoSizeText(
                localization.tap,
                maxLines: 1,
                style: textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                localization.tapBody,
                maxLines: 2,
                style: textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Flexible(flex: 1, child: Container()),
      ],
    );
  }
}
