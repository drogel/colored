import 'package:colored/sources/presentation/widgets/animations/transition_switcher.dart';
import 'package:flutter/material.dart';

class PageBodySwitcher extends StatelessWidget {
  const PageBodySwitcher({
    required this.children,
    required this.currentIndex,
    this.reverse = false,
    this.type = PageTransitionType.fadeThrough,
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final int currentIndex;
  final PageTransitionType type;
  final bool reverse;

  @override
  Widget build(BuildContext context) => TransitionSwitcher(
        reverse: reverse,
        type: type,
        child: children[currentIndex],
      );
}
