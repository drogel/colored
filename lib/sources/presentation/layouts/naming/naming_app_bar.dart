import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_cross_fade_text.dart';
import 'package:flutter/material.dart';

class NamingAppBar extends StatelessWidget {
  const NamingAppBar({this.onSearchPressed, Key key}) : super(key: key);

  final void Function() onSearchPressed;

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context).converter;
    return AppBar(
      title: NamingCrossFadeText(defaultText: localization.colorConverter),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: onSearchPressed,
        ),
      ],
    );
  }
}
