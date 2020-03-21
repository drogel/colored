import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_buttons_layout.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_welcome_layout.dart';
import 'package:flutter/material.dart';

class OnBoardingLayout extends StatefulWidget {
  const OnBoardingLayout();

  @override
  _OnBoardingLayoutState createState() => _OnBoardingLayoutState();
}

class _OnBoardingLayoutState extends State<OnBoardingLayout> {
  final _scroll = PageController();

  @override
  Widget build(BuildContext context) => PageView(
    controller: _scroll,
    children: const <Widget>[
      OnBoardingWelcomeLayout(),
      OnBoardingButtonsLayout(),
    ],
  );
}

