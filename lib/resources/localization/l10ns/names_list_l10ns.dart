import 'package:colored/resources/localization/localization_provider.dart';

class NamesListL10ns extends LocaleCodeAware {
  const NamesListL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'search': 'Search colors',
      'noColorsFound': "Thousands of colors and I can't find that one!",
    },
    "es": {
      'search': 'Buscar colores',
      'noColorsFound': '¡Tengo miles de colores, pero no encuentro ese!',
    }
  };

  String get search => _values[localeCode]['search'];
  String get noColorsFound => _values[localeCode]['noColorsFound'];
}
