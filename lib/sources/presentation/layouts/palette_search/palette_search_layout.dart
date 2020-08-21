import 'package:colored/sources/presentation/layouts/palette_search/palette_search_field.dart';
import 'package:flutter/material.dart';

class PaletteSearchLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const PaletteSearchLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        title: const PaletteSearchField(),
        centerTitle: true,
      );

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
