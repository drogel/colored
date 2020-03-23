import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;

class OnBoardingBodyLayout extends StatelessWidget {
  const OnBoardingBodyLayout({
    @required this.children,
    Key key,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(padding.largeText),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      );
}
