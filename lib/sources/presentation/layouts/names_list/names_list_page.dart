import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:colored/sources/domain/view_models/main_tabs/main_tabs_data.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class NamesListPage extends StatelessWidget implements TabPage {
  const NamesListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      NamesListLayout(
          onColorCardPressed: (color) => _notifyColorSelected(context, color),
      );

  // TODO(drogel) - Add localized label name.
  @override
  String getTabTitle(BuildContext context) => "Colors";

  @override
  IconData get tabIcon => Icons.search;

  void _notifyColorSelected(BuildContext context, Color color) {
    final selection = ColorSelection.fromColor(color);
    FocusScope.of(context).unfocus();
    TransformerData.of(context).onSelectionEnded(selection);
    MainTabsData.of(context).onNavigation(MainTabsSelection.converter);
  }
}
