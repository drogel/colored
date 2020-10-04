import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class NamesListPage extends StatelessWidget implements TabPage {
  const NamesListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => NamesListLayout(
        onColorCardPressed: (color) => _notifyColorSelected(context, color),
      );

  @override
  String getTabTitle(BuildContext context) =>
      Localization.of(context).namesList.pageTitle;

  @override
  IconData get tabIcon => Icons.search;

  void _notifyColorSelected(BuildContext context, Color color) {
    final selection = ColorSelection.fromColor(color);
    final destinationIndex = MainTabsSelection.converter.index;
    FocusScope.of(context).unfocus();
    TransformerData.of(context).onSelectionEnded(selection);
    MainTabsData.of(context).onNavigation(destinationIndex);
  }
}
