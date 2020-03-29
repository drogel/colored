import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/navigation/on_boarding_router.dart';
import 'package:colored/sources/app/styling/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Colored extends StatelessWidget {
  const Colored({@required this.initialRoute, Key key})
      : assert(initialRoute != null),
        super(key: key);

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    const onBoardingRouter = OnBoardingRouter();
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        const ColoredLocalizationDelegate(),
      ],
      supportedLocales: const [Locale("en"), Locale("es")],
      title: "Colored",
      theme: theme.dark(context),
      initialRoute: initialRoute,
      onGenerateRoute: onBoardingRouter.generateRoute,
    );
  }
}
