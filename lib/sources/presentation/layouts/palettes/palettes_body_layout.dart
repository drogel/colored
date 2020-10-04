import 'package:colored/sources/domain/view_models/palettes_navigation/palettes_navigation_data.dart';
import 'package:colored/sources/presentation/layouts/lists/palettes_list/palettes_list_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/page_body_switcher.dart';
import 'package:flutter/material.dart';

class PalettesBodyLayout extends StatelessWidget {
  const PalettesBodyLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selection = PalettesNavigationData.of(context).state.currentIndex;
    return PageBodySwitcher(
      currentIndex: selection,
      children: const [
        PalettesListLayout(),
        Scaffold(),
      ],
    );
  }
}
