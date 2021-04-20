import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/app/styling/style.dart';
import 'package:colored/sources/app/styling/theme/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Colored extends StatelessWidget {
  const Colored({
    @required this.router,
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
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale("en"), Locale("es")],
            debugShowCheckedModeBanner: false,
            title: "Colored",
            theme: lightTheme,
            darkTheme: darkTheme,
            onGenerateRoute: router.onGenerateRoute,
          ),
        ),
      );
}
