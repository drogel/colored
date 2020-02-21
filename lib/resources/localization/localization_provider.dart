abstract class LocaleCodeAware {
  LocaleCodeAware(this.localeCode);

  final String localeCode;
}

mixin LocalizationProvider on LocaleCodeAware {
  static final Map<String, Map<String, String>> _values = {
    'en': {
      'appTitle': 'Colored',
    },
    "es": {
      'appTitle': 'Colored',
    }
  };

  String get appTitle => _values[localeCode]['appTitle'];
}