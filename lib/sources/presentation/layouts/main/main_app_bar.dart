import 'package:colored/sources/presentation/widgets/animations/default_animated_switcher.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    @required this.children,
    @required this.currentIndex,
    Key key,
  })  : assert(children != null),
        assert(currentIndex != null),
        super(key: key);

  final List<PreferredSizeWidget> children;
  final int currentIndex;

  @override
  Widget build(BuildContext context) => DefaultAnimatedSwitcher(
        child: children[currentIndex],
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
