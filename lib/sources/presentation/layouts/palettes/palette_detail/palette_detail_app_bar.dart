import 'package:colored/sources/domain/data_models/palettes_navigation_selection.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:flutter/material.dart';

class PaletteDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PaletteDetailAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigation = PalettesNavigationData.of(context)!;
    final data = PaletteDetailData.of(context)!.state;
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(
        onPressed: () => _navigateBackToPalettes(navigation),
      ),
      title: Text(data.paletteName),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  void _navigateBackToPalettes(PalettesNavigationData navigation) =>
      navigation.onNavigation(PalettesNavigationSelection.list.index);
}
