import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class EmptyListLayout extends StatelessWidget {
  const EmptyListLayout({this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      constraints: const BoxConstraints.expand(),
      padding: EdgeInsets.symmetric(
        horizontal: padding.base,
        vertical: padding.vertical.top,
      ),
      child: child,
    );
  }
}
