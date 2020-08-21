import 'package:colored/resources/localization/localization_provider.dart';

class PalettesL10ns extends LocaleCodeAware {
  const PalettesL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'pageTitle' : 'Palettes',
      'noPalettesFound': 'Oops! No palettes seem to be matching that name.',
    },
    "es": {
      'pageTitle' : 'Paletas',
      'noPalettesFound': 'Ups! No parece haber paletas con ese nombre.',
    }
  };

  String get pageTitle => _values[localeCode]['pageTitle'];
  String get noPalettesFound => _values[localeCode]['noPalettesFound'];
}