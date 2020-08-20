import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/containers/background_container.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class PalettesListPage extends StatelessWidget implements TabPage {
  const PalettesListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const BackgroundContainer();

  @override
  String getTabTitle(BuildContext context) =>
      Localization.of(context).palettes.pageTitle;

  @override
  IconData get tabIcon => Icons.palette;
}
