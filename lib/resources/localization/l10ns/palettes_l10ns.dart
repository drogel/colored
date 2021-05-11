import 'package:colored/resources/localization/localization_provider.dart';

class PalettesL10ns extends LocaleCodeAware {
  const PalettesL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'pageTitle': 'Palettes',
      'search': "Try 'Midnight'",
      'noPalettesFound': 'Oops! No palettes seem to be matching that name.',
      'detailLoadingError':
          'There was an error loading this palette. Try again later. Sorry!'
    },
    "es": {
      'pageTitle': 'Paletas',
      'search': 'Prueba "Midnight"',
      'noPalettesFound': 'Ups! No parece haber paletas con ese nombre.',
      'detailLoadingError':
          'Hubo un error cargando esta paleta. Inténtalo de nuevo más tarde.'
    }
  };

  String get pageTitle => _values[localeCode]!['pageTitle']!;
  String get noPalettesFound => _values[localeCode]!['noPalettesFound']!;
  String get search => _values[localeCode]!['search']!;
  String get detailLoadingError => _values[localeCode]!['detailLoadingError']!;
}
