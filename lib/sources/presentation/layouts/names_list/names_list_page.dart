import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class NamesListPage extends StatelessWidget implements TabPage {
  const NamesListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => NamesListLayout(
        onColorCardPressed: (color) => debugPrint(color.toString()),
      );

  @override
  String getTabTitle(BuildContext context) => "Colors";

  @override
  IconData get tabIcon => Icons.search;
}
