import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Colored extends StatelessWidget {
  const Colored({@required this.home, Key key})
      : assert(home != null),
        super(key: key);

  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          const ColoredLocalizationDelegate(),
        ],
        supportedLocales: const [Locale("en"), Locale("es")],
        title: "Colored",
        theme: theme.dark(context),
        home: home,
      );
}
