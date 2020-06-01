import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:colored/sources/app/styling/colors/dark_color_scheme.dart';
import 'package:colored/sources/app/styling/colored_theme_wrapper.dart';
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
  Widget build(BuildContext context) {
    const darkThemeWrapper = ColoredThemeWrapper(colors: DarkColorScheme());
    return MaterialApp(
      localizationsDelegates: [
        const ColoredLocalizationDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("es")],
      title: "Colored",
      theme: darkThemeWrapper.getThemeData(),
      darkTheme: darkThemeWrapper.getThemeData(),
      onGenerateRoute: router.generateRoute,
    );
  }
}
