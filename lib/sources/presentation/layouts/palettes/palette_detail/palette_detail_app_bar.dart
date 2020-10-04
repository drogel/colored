import 'package:flutter/material.dart';

class PaletteDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PaletteDetailAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar();

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
