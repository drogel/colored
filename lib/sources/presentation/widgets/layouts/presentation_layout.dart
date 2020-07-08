import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class PresentationLayout extends StatelessWidget {
  const PresentationLayout({
    @required this.children,
    this.columnAlignment = MainAxisAlignment.start,
    Key key,
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment columnAlignment;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
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
}
