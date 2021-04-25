import 'package:flutter/material.dart';

class DynamicRow extends StatelessWidget {
  const DynamicRow({
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var i = 0; i < itemCount; i += 1) {
      children.add(itemBuilder(context, i));
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}
