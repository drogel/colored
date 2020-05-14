import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:colored/sources/app/styling/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Colored extends StatelessWidget {
  const Colored({
    this.router = const OnBoardingRouter(),
    Key key,
  })  : assert(router != null),
        super(key: key);

  final FlowRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          const ColoredLocalizationDelegate(),
        ],
        supportedLocales: const [Locale("en"), Locale("es")],
        title: "Colored",
        theme: theme.dark(context),
        onGenerateRoute: router.generateRoute,
      );
}
