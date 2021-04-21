import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/converter/connectivity/connectivity_bar.dart';
import 'package:colored/sources/presentation/layouts/converter/connectivity/connectivity_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/converter/converter_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/naming/naming_error_row.dart';
import 'package:colored/sources/presentation/layouts/converter/transformer/transformer_layout.dart';
import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

class ConverterPage extends StatelessWidget implements TabPage {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const ConnectivityLayout(
        body: ConverterLayout(background: TransformerLayout()),
        child: ConnectivityBar(child: NamingErrorRow()),
      );

  @override
  String? getTabTitle(BuildContext context) =>
      Localization.of(context)!.converter.pageTitle;

  @override
  IconData get tabIcon => Icons.tune;
}
