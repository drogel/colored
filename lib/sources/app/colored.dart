import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/navigation/routers/flow_router.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:colored/sources/app/styling/colors/dark_color_scheme.dart';
import 'package:colored/sources/app/styling/colored_theme_wrapper.dart';
import 'package:colored/sources/app/styling/fonts/default_fonts.dart';
import 'package:colored/sources/app/styling/opacity/default_opacity.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/padding/default_padding.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
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
  Widget build(BuildContext context) => PaddingData(
        paddingScheme: const DefaultPadding(),
        child: OpacityData(
          opacityScheme: const DefaultOpacity(),
          child: Builder(
            builder: (context) {
              final opacityScheme = OpacityData.of(context).opacityScheme;
              final darkThemeWrapper = ColoredThemeWrapper(
                colors: const DarkColorScheme(),
                opacity: opacityScheme,
                fonts: const DefaultFonts(),
              );
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
            },
          ),
        ),
      );
}
