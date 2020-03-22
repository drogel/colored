import 'package:colored/resources/asset_paths.dart' as paths;
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/faded_in_image.dart';
import 'package:flutter/material.dart';

const _kSpacing = 32.0;

class OnBoardingWelcomeLayout extends StatelessWidget {
  const OnBoardingWelcomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final localization = Localization.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(_kSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadedInImage(
              image: Image.asset(paths.largeLogo).image,
              size: 0.618 * MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: _kSpacing),
            Text(localization.onBoarding.welcome, style: textTheme.display1),
            Text(localization.appTitle, style: textTheme.display3),
            const SizedBox(height: 2 * _kSpacing),
            Text(
              localization.onBoarding.slogan,
              style: textTheme.headline,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
