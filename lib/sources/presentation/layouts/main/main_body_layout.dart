import 'package:colored/sources/presentation/widgets/animations/default_transition_switcher.dart';
import 'package:flutter/material.dart';

class MainBodyLayout extends StatelessWidget {
  const MainBodyLayout({
    @required this.children,
    @required this.currentIndex,
    Key key,
  })  : assert(children != null),
        assert(currentIndex != null),
        super(key: key);

  final List<Widget> children;
  final int currentIndex;

  @override
  Widget build(BuildContext context) => DefaultTransitionSwitcher(
        child: children[currentIndex],
      );
}
