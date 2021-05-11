import '../localization_provider.dart';

class NamingL10ns extends LocaleCodeAware {
  const NamingL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'noConnection': 'I need the internet to find color names!',
    },
    "es": {
      'noConnection': 'Necesito internet para saber el nombre de este color',
    }
  };

  String get noConnection => _values[localeCode]!['noConnection']!;
}
