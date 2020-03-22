import 'package:flutter/material.dart';

class OnBoardingButtonsLayout extends StatelessWidget {
  const OnBoardingButtonsLayout({
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
    return Scaffold(
      backgroundColor: Color.lerp(primaryColor, secondary, colorLerpValue),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FlutterLogo(size: 100),
            const SizedBox(height: 32),
            Text("Buttons", style: textTheme.display3),
          ],
        ),
      ),
    );
  }
}
