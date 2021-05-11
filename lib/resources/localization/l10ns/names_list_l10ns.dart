import 'package:colored/resources/localization/localization_provider.dart';

class NamesListL10ns extends LocaleCodeAware {
  const NamesListL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'pageTitle': 'Colors',
      'search': "Try 'Blue' or '#7FC6BE'",
      'noColorsFound': "Thousands of colors and I can't find that one!",
    },
    "es": {
      'pageTitle': 'Colores',
      'search': 'Prueba "Blue" o "#7FC6BE"',
      'noColorsFound': '¡Tengo miles de colores, pero no encuentro ese!',
    }
  };

  String get pageTitle => _values[localeCode]!['pageTitle']!;
  String get search => _values[localeCode]!['search']!;
  String get noColorsFound => _values[localeCode]!['noColorsFound']!;
}
