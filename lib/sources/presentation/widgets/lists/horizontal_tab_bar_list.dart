import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class HorizontalTabBarList extends StatelessWidget {
  const HorizontalTabBarList({
    required this.itemCount,
    required this.itemBuilder,
    Key? key,
  })  : assert(itemCount != null),
        assert(itemBuilder != null),
        super(key: key);

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
    final safeArea = MediaQuery.of(context).padding;
    final horizontalPadding = padding.small.horizontal;
    return SizedBox(
      height: kTextTabBarHeight,
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: safeArea.left + horizontalPadding,
          right: safeArea.right + 2 * horizontalPadding,
        ),
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
