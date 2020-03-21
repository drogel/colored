import 'package:flutter/material.dart';

class OnBoardingButtonsLayout extends StatelessWidget {
  const OnBoardingButtonsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
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