import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/palettes/palettes_navigation/palettes_body_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class PalettesPage extends StatelessWidget implements TabPage {
  const PalettesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const PalettesBodyLayout();

  @override
  String? getTabTitle(BuildContext context) =>
      Localization.of(context)!.palettes.pageTitle;

  @override
  IconData get tabIcon => Icons.palette;
}

