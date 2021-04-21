import 'package:colored/sources/domain/data_models/palettes_navigation_selection.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:colored/sources/presentation/layouts/palettes/palette_detail/palette_detail_layout.dart';
import 'package:colored/sources/presentation/layouts/palettes/palettes_list/palettes_list_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/transition_switcher.dart';
import 'package:colored/sources/presentation/widgets/animations/page_body_switcher.dart';
import 'package:flutter/material.dart';

class PalettesBodyLayout extends StatelessWidget {
  const PalettesBodyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selection = PalettesNavigationData.of(context)!.state!.currentIndex;
    return PageBodySwitcher(
      reverse: selection == PalettesNavigationSelection.list.index,
      type: PageTransitionType.sharedZAxis,
      currentIndex: selection,
      children: const [
        PalettesListLayout(),
        PaletteDetailLayout(),
      ],
    );
  }
}
