import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:colored/sources/app/styling/theme/theme_builder.dart';
import 'package:colored/sources/app/styling/style.dart';
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
  Widget build(BuildContext context) => Style(
        child: ThemeBuilder(
          builder: (lightTheme, darkTheme) => MaterialApp(
            localizationsDelegates: const [
              ColoredLocalizationDelegate(),
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: const [Locale("en"), Locale("es")],
            title: "Colored",
            theme: lightTheme,
            darkTheme: darkTheme,
            onGenerateRoute: router.generateRoute,
          ),
        ),
      );
}
