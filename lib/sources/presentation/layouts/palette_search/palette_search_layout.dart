import 'package:flutter/material.dart';

class PaletteSearchLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const PaletteSearchLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar();

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
