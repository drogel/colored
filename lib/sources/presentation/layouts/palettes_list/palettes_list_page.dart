import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_injector.dart';
import 'package:colored/sources/presentation/layouts/palettes_list/palettes_list_layout.dart';
import 'package:colored/sources/presentation/notifiers/palettes_list_notifier.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class PalettesListPage extends StatelessWidget implements TabPage {
  const PalettesListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const PalettesListNotifier(
        injector: PalettesListInjector(),
        child: PalettesListLayout(),
      );

  @override
  String getTabTitle(BuildContext context) =>
      Localization.of(context).palettes.pageTitle;

  @override
  IconData get tabIcon => Icons.palette;
}
