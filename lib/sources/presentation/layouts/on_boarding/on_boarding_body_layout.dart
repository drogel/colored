import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;

class OnBoardingBodyLayout extends StatelessWidget {
  const OnBoardingBodyLayout({
    @required this.children,
    this.columnAlignment = MainAxisAlignment.center,
    Key key,
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment columnAlignment;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(padding.largeText),
          child: Column(
            mainAxisAlignment: columnAlignment,
            children: children,
          ),
        ),
      );
}
