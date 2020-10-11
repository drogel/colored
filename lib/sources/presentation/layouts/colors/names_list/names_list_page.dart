import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/colors/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class NamesListPage extends StatelessWidget implements TabPage {
  const NamesListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const NamesListLayout();

  @override
  String getTabTitle(BuildContext context) =>
      Localization.of(context).namesList.pageTitle;

  @override
  IconData get tabIcon => Icons.search;
}
