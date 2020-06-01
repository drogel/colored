import 'package:flutter/material.dart';
import 'file:///D:/Programas/Flutter/colored/colored/lib/sources/app/styling/padding/padding_constants.dart' as padding;

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
            left: padding.large,
            right: padding.large,
            top: 2 * padding.large,
            bottom: padding.large,
          ),
          child: Column(
            mainAxisAlignment: columnAlignment,
            children: children,
          ),
        ),
      );
}
