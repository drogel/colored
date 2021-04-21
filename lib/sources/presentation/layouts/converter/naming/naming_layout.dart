import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/converter/naming/naming_cross_fade_text.dart';
import 'package:colored/sources/presentation/layouts/converter/picker/picker_tab_bar.dart';
import 'package:flutter/material.dart';

class NamingLayout extends StatelessWidget implements PreferredSizeWidget {
  const NamingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context)!.converter;
    return AppBar(
      title: NamingCrossFadeText(defaultText: localization.colorConverter!),
      bottom: const PickerTabBar(),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
