import 'package:colored/sources/domain/data_models/palettes_navigation_selection.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_navigation/palettes_navigation_data.dart';
import 'package:flutter/material.dart';

class PaletteDetailLayout extends StatelessWidget {
  const PaletteDetailLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigation = PalettesNavigationData.of(context);
    return WillPopScope(
      onWillPop: () => _onBackPressed(navigation),
      child: Container(color: Colors.amber),
    );
  }

  Future<bool> _onBackPressed(PalettesNavigationData navigation) async {
    navigation.onNavigation(PalettesNavigationSelection.list.index);
    return false;
  }
}
