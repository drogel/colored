import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        super(key: key);

  final Widget child;
  final OnBoardingInjector injector;

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) => OnBoardingData(
        child: widget.child,
      );
}
