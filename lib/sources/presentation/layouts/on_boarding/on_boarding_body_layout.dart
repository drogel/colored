import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;

class OnBoardingBodyLayout extends StatelessWidget {
  const OnBoardingBodyLayout({
    @required this.children,
    this.columnAlignment = MainAxisAlignment.start,
    Key key,
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment columnAlignment;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: padding.largeText,
            right: padding.largeText,
            top: 2 * padding.largeText,
            bottom: padding.largeText,
          ),
          child: Column(
            mainAxisAlignment: columnAlignment,
            children: children,
          ),
        ),
      );
}
