import 'package:colored/resources/localization/localization_provider.dart';

class NamesListL10ns extends LocaleCodeAware {
  const NamesListL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'search': 'Search colors',
    },
    "es": {
      'search': 'Buscar colores',
    }
  };

  String get search => _values[localeCode]['search'];
}
