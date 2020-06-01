import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding/padding_constants.dart' as padding;

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
            left: padding.base,
            right: padding.base,
            top: 2 * padding.base,
            bottom: padding.base,
          ),
          child: Column(
            mainAxisAlignment: columnAlignment,
            children: children,
          ),
        ),
      );
}
