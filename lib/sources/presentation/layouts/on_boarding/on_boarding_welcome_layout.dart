import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/animations/faded_in_image.dart';
import 'package:colored/sources/presentation/widgets/layouts/presentation_layout.dart';
import 'package:flutter/material.dart';

class OnBoardingWelcomeLayout extends StatelessWidget {
  const OnBoardingWelcomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final localization = Localization.of(context)!;
    return PresentationLayout(
      columnAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FadedInImage(
          image: Image.asset(paths.largeLogo).image,
          size: 0.618 * MediaQuery.of(context).size.width,
        ),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Column(
            children: <Widget>[
              Text(localization.onBoarding.welcome, style: textTheme.headline4),
              Text(localization.appTitle, style: textTheme.headline2),
            ],
          ),
        ),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            localization.onBoarding.slogan,
            style: textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
