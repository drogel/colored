import 'dart:async';
import 'package:colored/resources/localization/localization_provider.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class Localization extends LocaleCodeAware with LocalizationProvider {
  Localization(this.locale) : super(locale.toString());

  final Locale locale;

  static Localization? of(BuildContext context) =>
      Localizations.of<Localization>(context, Localization);
}

class ColoredLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const ColoredLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en'].contains(locale.toString()) || ['es'].contains(locale.toString());

  @override
  Future<Localization> load(Locale locale) =>
      SynchronousFuture<Localization>(Localization(locale));

  @override
  bool shouldReload(ColoredLocalizationDelegate old) => false;
}
