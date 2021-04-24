import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:colored/sources/presentation/layouts/palettes/palette_detail/palette_detail_app_bar.dart';
import 'package:colored/sources/presentation/layouts/palettes/palette_search/palette_search_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/app_bar_switcher.dart';
import 'package:flutter/material.dart';

class PalettesAppBarLayout extends StatelessWidget
    implements PreferredSizeWidget {
  const PalettesAppBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selection = PalettesNavigationData.of(context)!.state.currentIndex;
    return AppBarSwitcher(
      currentIndex: selection,
      children: const [
        PaletteSearchLayout(),
        PaletteDetailAppBar(),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
