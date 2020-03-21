import 'package:colored/resources/localization/localization.dart';
import 'package:flutter/material.dart';

class OnBoardingWelcomeLayout extends StatelessWidget {
  const OnBoardingWelcomeLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localization = Localization.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
