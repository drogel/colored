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
      'hex': 'Hex',
      'rgb': 'RGB',
      'colorConverter': 'Color converter',
    },
    "es": {
      'appTitle': 'Colored',
      'tooltipMessage': '¡Copiado!',
      'tooltipError': 'Formato no válido',
      'hex': 'Hex',
      'rgb': 'RGB',
      'colorConverter': 'Conversor de colores',
    }
  };

  String get appTitle => _values[localeCode]['appTitle'];
  String get tooltipMessage => _values[localeCode]['tooltipMessage'];
  String get tooltipError => _values[localeCode]['tooltipError'];
  String get hex => _values[localeCode]['hex'];
  String get rgb => _values[localeCode]['rgb'];
  String get colorConverter => _values[localeCode]['colorConverter'];
}