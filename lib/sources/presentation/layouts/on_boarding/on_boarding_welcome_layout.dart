import 'package:colored/resources/localization/localization.dart';
import 'package:flutter/material.dart';

class OnBoardingWelcomeLayout extends StatelessWidget {
  const OnBoardingWelcomeLayout({
    @required this.colorLerpValue,
    Key key,
  }) : super(key: key);

  final double colorLerpValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final localization = Localization.of(context);
    return Scaffold(
      backgroundColor: Color.lerp(primaryColor, secondary, colorLerpValue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FlutterLogo(size: 100),
            const SizedBox(height: 32),
            Text(localization.onBoarding.welcome, style: textTheme.display1),
            Text(localization.appTitle, style: textTheme.display3),
          ],
        ),
      ),
    );
  }
}
