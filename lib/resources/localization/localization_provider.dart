abstract class LocaleCodeAware {
  LocaleCodeAware(this.localeCode);

  final String localeCode;
}

mixin LocalizationProvider on LocaleCodeAware {
  static final Map<String, Map<String, String>> _values = {
    'en': {
      'appTitle': 'Colored',
      'tooltipMessage': 'Copied!',
      'tooltipError': 'Wrong format',
    },
    "es": {
      'appTitle': 'Colored',
      'tooltipMessage': '¡Copiado!',
      'tooltipError': 'Formato no válido',
    }
  };

  String get appTitle => _values[localeCode]['appTitle'];
  String get tooltipMessage => _values[localeCode]['tooltipMessage'];
  String get tooltipError => _values[localeCode]['tooltipError'];
}